require 'spec_helper'

describe Entrance do
  describe 'обладает связями с другими моделями:' do
    it 'c приемной кампанией' do
      should have_many(:campaign)
    end

    it 'с формой образования' do
      should belong_to(:education_form)
    end

    it 'с типом образования' do
      should belong_to(:education_type)
    end

    it 'с пройденым образованием' do
      should belong_to(:education_source)
    end
  end
end
