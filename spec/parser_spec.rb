require 'spec_helper'

describe Parser do
  subject { Parser.new('sync_assignment_client_data.csv') }

  it 'responds to floors, #floors' do
    expect(subject).to respond_to :floors
  end

  it 'returns an array of floors, #floors' do
    expect(subject.floors).to be_an_instance_of Array
    subject.floors.each do |floor|
      expect(floor).to be_an_instance_of Floor
    end
  end

  it 'responds to apartments' do
    expect(subject).to respond_to :apartments
  end

  it 'returns an array of apartment, #apartments' do
    expect(subject.apartments).to be_an_instance_of Array
    subject.apartments.each do |apartment|
      expect(apartment).to be_an_instance_of Apartment
    end
  end

  it 'responds to residents' do
    expect(subject).to respond_to :residents
  end

  it 'returns an array of resident, #residents' do
    expect(subject.residents).to be_an_instance_of Array
    subject.residents.each do |resident|
      expect(resident).to be_an_instance_of Resident
    end
  end
end
