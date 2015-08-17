require 'spec_helper'

describe API::V1::Procedure do

  it 'should create a new procedure with the generic name.' do
    post "#{@base_url}/procedures", {:description => 'Description'}
    expect_json({:name => Model::Procedure::DEFAULT_NAME, :description => 'Description'})
  end

  it 'should delete procedure.' do
    delete "#{@base_url}/procedures/1"
    expect_status 204
  end

  it 'should give status 204 when deleting a nonexisting procedure.' do
    delete "#{@base_url}/procedures/1000"
    expect_status 404
  end

  it 'should create a procedure when using PUT with a nonexistent ID.' do
    put "#{@base_url}/procedures/1000", {}
    expect_json({:id => 1000, :name => Model::Procedure::DEFAULT_NAME})
    expect_status 201
  end

  it 'should update an existing procedure.' do
    put "#{@base_url}/procedures/1000", {:name => 'Changed Name', :description => 'Changed Desc'}
    expect_json({:name => 'Changed Name', :description => 'Changed Desc'})
    expect_status 200
  end

  it 'should get an existing procedure.' do
    get "#{@base_url}/procedures/1000"
    expect_json({:name => 'Changed Name', :description => 'Changed Desc'})
    expect_status 200
  end

  it 'should get all procedures.' do
    get "#{@base_url}/procedures"
    expect_json_sizes 1
    expect_json('0', {:name => 'Changed Name', :description => 'Changed Desc'})
    expect_status 200
  end

end