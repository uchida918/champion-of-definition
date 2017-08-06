class TestsController < ApplicationController
  @@test_count = 0
  @@answers = []

  def start
    p "start"
    p @@test_count
    p @datas = Definition.all.sample(5).pluck(:id).join(' ')
    @@test_count = 0
    @@answers = []
  end
  
  def question
    p @datas = params[:datas].split(' ')
    if @@test_count >= 5
      return redirect_to tests_result_url(datas: @datas)
    end
    p "question"
    p @@test_count
    p @definition = Definition.find(@datas[@@test_count])
      @user_definition = UserDefinition.find_by(definition_id: @datas[@@test_count])
  end
  
  def post_answer
    @@test_count += 1
    p "post_answer"
    p @@test_count
    p @datas = params[:datas].split(' ')
    p @answer = params[:test][:answer]
    p @@answers << @answer
    redirect_to tests_answer_path(datas: @datas)
  end
  
  def get_answer
    p @@test_count
    p "get_answer"
    p params
    p @datas = params[:datas].split(' ').flatten
    p @@answers
    @definition =  Definition.find(@datas[@@test_count - 1])
    @user_definition = UserDefinition.find_by(definition_id: @datas[@@test_count - 1])
    @answer = @@answers[@@test_count - 1]
    render :answer
  end
  
  def result
    p @answers = @@answers
    p @datas = params[:datas].map!(&:to_i)
  end
end
