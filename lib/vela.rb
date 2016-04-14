require "vela/version"
require 'mysql2'
require 'pg'

module Vela
  class DB
    attr_reader :src_conn, :dst_conn, :src_adapter, :dst_adapter, :src_tbl, :dst_tbl, :columns
    def initialize(src_tbl=nil,dst_tbl=nil, src_adapter=nil, dst_adapter=nil)
      @src_conn = nil
      @dst_conn = nil
      @src_adapter = src_adapter
      @dst_adapter = dst_adapter
      @src_tbl = src_tbl
      @dst_tbl = dst_tbl
      @columns = nil
    end

    def src_connection(args)
      @src_adapter = args[:adapter]
      @src_conn = get_adapter_connection(args)
    end

    def dst_connection(args)
      @dst_adapter = args[:adapter]
      @dst_conn = get_adapter_connection(args)
    end

    def select_query
      sqry = "SELECT * from #{@src_tbl} limit 50"
      (@src_adapter.eql? "mysql") ? @src_conn.query(sqry) : @src_conn.exec(sqry)
    end

    def insert_query(columns, d_signs, rcrd)
      begin

        statement = "insert into %s (%s) values (%s)" % [@dst_tbl,columns,d_signs]
        if @dst_adapter.eql? "postgresql"
          @dst_conn.prepare("statement#{rcrd['id']}", statement)
          @dst_conn.exec_prepared("statement#{rcrd['id']}",rcrd.values)
        else
          values = rcrd.values.to_s.tr!('[]', '').gsub('nil', 'null')

          statement = "insert into %s (%s) values (%s)" % [@dst_tbl,columns,values]
          @dst_conn.query(statement)
        end

      rescue Exception => e
        puts e
      end
    end

    def sql_sync
      select_query.each do |rcrd|

        d_signs = build_dollar_signs(rcrd)
        rcrd = rename_keys(rcrd, @columns)
        columns = rcrd.keys.to_s.tr('[]:"','')
        insert_query(columns, d_signs, rcrd)
      end

    end # db_sql_sync

    def dbsync(src_tbl, dst_tbl, options)
      @columns = options
      @src_tbl = src_tbl
      @dst_tbl = dst_tbl
      sql_sync
    end

    def get_adapter_connection(args)
      case args[:adapter]
      when "mysql"
        Mysql2::Client.new(host: args[:host], user: args[:user], password: args[:password], database: args[:database])
      when "postgresql"
        PG.connect(host: args[:host], user: args[:user], password: args[:password], dbname: args[:database])
      else
        puts "adapter is not supported!"
      end
    end

    # swap key and values
    def rename_keys(record, cols)
      cols.nil? ? record : Hash[record.map { |k, v| [(cols[k] || k).to_sym ,v] }]
    end


    def build_dollar_signs(rcrd)
      d_signs = ''
      rcrd.length.times do |i|
        d_signs += "$#{i+1},"
      end
      # remove the last comma
      d_signs.chomp!(',')
    end

  end

end
