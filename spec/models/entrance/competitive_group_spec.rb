require 'spec_helper'

describe Entrance do
  describe 'обладает связями с другими моделями:' do
    it 'c предметами' do
      should have_many(:items)
    end

    it 'c целевыми организациями' do
      should have_many(:target_organizations)
    end

    it 'c тестовыми предметами' do
      should have_many(:test_items)
    end

    it 'c общими выгодами' do
      should have_many(:common_benefits)
    end

    it 'c приемной кампанией' do
      should belong_to(:campaign)
    end    
  end
end
