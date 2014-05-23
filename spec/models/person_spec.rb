require 'spec_helper'

describe Person do
  
  describe 'обладает связями с другими моделями:' do
    it 'с фамилией' do
      should  belong_to(:fname)
    end
    
    it 'с именем' do
      should  belong_to(:iname)
    end
    
    it 'с отчеством' do
      should  belong_to(:oname)
    end
    
    it 'с комнатой' do
      should  belong_to(:room)
    end
    
    it 'со студентами' do
      should has_many(:students)
    end
  end
end
