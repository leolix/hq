require 'spec_helper'

describe ActiveRecord::Base do
  describe 'обладает связями с другими моделями:' do
    it 'с предметом' do
      expect belong_to(:subject)
    end

    it 'с группой' do
      expect belong_to(:group)
    end

    it 'со студентом' do
      expect belong_to(:student)
    end

    it 'c экзаменом студента' do
      expect have_many(:exam_student)
    end

    it 'c оценками' do
      expect have_many(:marks)
    end
  end
end
