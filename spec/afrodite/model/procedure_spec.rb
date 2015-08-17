require 'spec_helper'

describe Model::Procedure do

  it {should have_property :name }
  it {should have_property :description }
  it { should have_many :steps }
  it { should validate_presence_of :name }

end