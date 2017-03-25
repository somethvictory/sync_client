require 'spec_helper'

describe SyncService do
  subject { SyncService.new('sync_assignment_client_data.csv') }

  it 'syncs floors, apartments and residents' do
    expect(subject).to receive(:sync_floors)
    expect(subject).to receive(:sync_apartments)
    expect(subject).to receive(:sync_residents)
    subject.sync
  end

  xit 'syncs all related items' do
    #Couldnot come up with a solution yet
  end
end
