require 'spec_helper'

describe Study::CheckpointmarksController do
  context 'для разработчиков' do
    before do
      @user = FactoryGirl.create(:developer)
      @discipline = FactoryGirl.create(:discipline_with_controls,  subject_teacher: @user.id, group: FactoryGirl.create(:group))
      @checkpoint = @discipline.checkpoints.first
      @student = FactoryGirl.create(:student, person: FactoryGirl.create(:person, fname: FactoryGirl.create(:dictionary),
       iname: FactoryGirl.create(:dictionary), oname: FactoryGirl.create(:dictionary)), group: @discipline.group)
      @other_student = FactoryGirl.create(:student, person: FactoryGirl.create(:person, fname: FactoryGirl.create(:dictionary),
                                                                         iname: FactoryGirl.create(:dictionary), oname: FactoryGirl.create(:dictionary)), group: @discipline.group)
      sign_in @user
    end

    describe 'GET "index"' do
      before :each do
        @checkpointmark = FactoryGirl.create(:practical_mark,  student: @student,
                                         checkpoint: @checkpoint)
        get :index, discipline_id: @discipline, checkpoint_id: @checkpoint
      end

      it 'должен выполняться успешно' do
        response.should be_success
      end

      it 'должен выводить правильное представление' do
        response.should render_template(:index)
      end

      it 'в выводе должна присутствовать тестовая оценка' do
        assigns(:checkpointmarks).should include(@checkpointmark)
      end
    end

    describe 'POST #create' do
      context 'если переданы параметры,' do
        before :each do
          post :create, discipline_id: @discipline, checkpoint_id: @checkpoint,
               checkpointmarks: [{mark: 2001, student: @other_student.id}, {mark: 2004, student: @student.id}]
        end

        it 'оценки должны сохраняться' do
          @checkpoint.checkpointmarks.should_not be_blank
        end

        it 'должно происходить перенаправление на оценки' do
          response.should redirect_to study_discipline_checkpoint_checkpointmarks_path(@discipline, @checkpoint)
        end
      end
      context 'если переданы параметры,' do
        before :each do
          post :create, discipline_id: @discipline, checkpoint_id: @checkpoint,
               checkpointmarks: []
        end

        it 'не должен сохранять оценки' do
          @checkpoint.checkpointmarks.should be_blank
        end

        it 'должно происходить перенаправление на оценки' do
          response.should redirect_to study_discipline_checkpoint_checkpointmarks_path(@discipline, @checkpoint)
        end
      end
    end

  end

  #context 'для пользователей, не являющихся разработчиками,' do
  #  it 'должен быть переход на страницу авторизации' do
  #    sign_in FactoryGirl.create(:user)
  #
  #    get :index
  #    response.should redirect_to(new_user_session_path)
  #  end
  #end

  context 'для не авторизованных пользователей' do
    it 'должен быть переход на страницу авторизации' do
      sign_out :user
      @discipline = FactoryGirl.create(:discipline_with_controls,  subject_teacher: FactoryGirl.create(:user).id, group: FactoryGirl.create(:group))
      @checkpoint = @discipline.checkpoints.first

      get :index, discipline_id: @discipline, checkpoint_id: @checkpoint
      response.should redirect_to(new_user_session_path)
    end
  end
end