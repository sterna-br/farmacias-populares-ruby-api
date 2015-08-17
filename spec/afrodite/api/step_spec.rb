require 'spec_helper'

describe API::V1::Procedure do

  it 'should create a new step with a generic name.' do
    post "#{@base_url}/procedures/1000/steps", {:description => 'Description'}
    expect_json({:name => Model::Step::DEFAULT_NAME, :description => 'Description'})
  end

  it 'should delete a step.' do
    delete "#{@base_url}/procedures/1000/steps/1"
    expect_status 204

    get "#{@base_url}/procedures/1000/steps"
    expect_json_sizes 0
    expect_status 200
  end

  it 'should give status 404 when deleting a nonexisting step.' do
    delete "#{@base_url}/procedures/1000/steps/1000"
    expect_status 404
  end

  it 'should give status 404 when trying to delete a step within a nonexistent procedure.' do
    delete "#{@base_url}/procedures/3000/steps/1000"
    expect_status 404
  end

  it 'should create a step when using PUT with a nonexistent ID.' do
    put "#{@base_url}/procedures/1000/steps/1000", {}
    expect_json({:id => 1000, :name => Model::Step::DEFAULT_NAME})
    expect_status 201
  end

  it 'should give status 404 when updating a step within nonexisting procedure.' do
    put "#{@base_url}/procedures/2000/steps/1000", {}
    expect_status 404
  end

  it 'should update an existing step.' do
    put "#{@base_url}/procedures/1000/steps/1000", {:name => 'Changed Name', :description => 'Changed Desc'}
    expect_json({:name => 'Changed Name', :description => 'Changed Desc'})
    expect_status 200
  end

  it 'should give status 404 when trying to get all steps from a nonexisting procedure.' do
    get "#{@base_url}/procedures/2000/steps"
    expect_status 404
  end

end