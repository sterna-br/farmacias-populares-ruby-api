require 'spec_helper'

describe Model::Step do

  it { should have_property :name }
  it { should have_property :description }
  it { should belong_to :procedure }
  it { should validate_presence_of :name }

  it 'should reorder the steps.' do
    proc = Model::Procedure.create(
       :name => 'Procedure'
    )

    Model::Step.create(
      :id => 1,
      :name => 'Step 1',
      :position => 2000,
      :procedure => proc
    )

    Model::Step.create(
        :id => 2,
        :name => 'Step 2',
        :position => 3000,
        :procedure => proc
    )

    Model::Step.reorder(proc.id)
    steps = Model::Procedure.get!(proc.id).steps
    expect(steps.count).to eq(2)

    expect(steps[0].id).to eq(1)
    expect(steps[0].position).to eq(1)

    expect(steps[1].id).to eq(2)
    expect(steps[1].position).to eq(2)
  end

end