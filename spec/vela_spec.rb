require 'spec_helper'

describe Vela do
  it 'has a version number' do
    expect(Vela::VERSION).not_to be nil
  end

  it 'builds a select query' do
    # v = Vela::DB.new
    # v.src_connection(user: 'root', password: 'pass', host: '127.0.0.1', database: 'testdb', adapter: 'mysql')
    # v.dst_connection(user: 'user', password: 'pass', host: '127.0.0.1', database: 'testpdb', adapter: 'postgresql')
    # expect(v.dbsync("t1", "t2", {"id" => 'uid'})).to eq("")

   #    v = Vela::DB.new
    # v.dst_connection(user: 'root', password: 'pass', host: '127.0.0.1', database: 'testdb', adapter: 'mysql')
    # v.src_connection(user: 'user', password: 'pass', host: '127.0.0.1', database: 'testpdb', adapter: 'postgresql')
    # expect(v.dbsync("t1", "t2", {"id" => 'uid'})).to eq("")
  end

  it 'swap key and values of hash one with hash 2' do
    v = Vela::DB.new
    record = {:id=>1, :name=>"post", :service_url=>"http://www.blog.de/posts.json", :description=>nil, :type=>"Post", :created_at=>'2012-12-13 16:03:32 +0100', :updated_at=>'2012-12-13 16:03:32 +0100', :sandbox_service_url=>"http://blog.de/posts.json"}
    cols = {sandbox_service_url: 'surl'}
    hash = v.rename_keys(record, cols)
    expect(hash).to eq({:id=>1, :name=>"post", :service_url=>"http://www.blog.de/posts.json", :description=>nil, :type=>"Post", :created_at=>'2012-12-13 16:03:32 +0100', :updated_at=>'2012-12-13 16:03:32 +0100', :surl=>"http://blog.de/posts.json"})
  end

  it 'generate $ signs for the query' do 
    record = {:id=>1, :name=>"post", :service_url=>"http://www.blog.de/posts.json", :description=>nil, :type=>"Post", :created_at=>'2012-12-13 16:03:32 +0100', :updated_at=>'2012-12-13 16:03:32 +0100', :sandbox_service_url=>"http://blog.de/posts.json"}
    v = Vela::DB.new
    expect(v.build_dollar_signs(record)).to eq("$1,$2,$3,$4,$5,$6,$7,$8")
  end

end
