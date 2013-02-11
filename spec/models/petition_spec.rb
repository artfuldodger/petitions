require 'spec_helper'

describe Petition do
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }

  context 'scopes' do
    let!(:undeleted) { FactoryGirl.create(:petition) }
    let!(:deleted)   { FactoryGirl.create(:petition, deleted_at: 1.day.ago) }

    describe 'default scope' do
      it 'excludes petitions marked as deleted' do
        Petition.all.should == [undeleted]
      end
    end

    describe '.deleted' do
      it 'excludes petitions NOT marked as deleted' do
        Petition.deleted.should == [deleted]
      end
    end
  end
end
