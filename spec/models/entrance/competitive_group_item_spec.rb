require 'spec_helper'

describe Entrance do
  describe 'обладает связями с другими моделями:' do
    it 'c конкурсной группой' do
      should belong_to(:competitive_group)
    end
    
    it 'c дирекцией' do
      should belong_to(:direction)
    end 

    it 'c уровнем образования' do
      should belong_to(:education_level)
    end 
  end
end
