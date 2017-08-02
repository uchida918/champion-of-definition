class TestsController < ApplicationController
  @@test_count = 0
  @@answers = []

  def start
    p "start"
    p @@test_count
    p @datas = Definition.all.sample(5).pluck(:id).map(&:to_i)
    @@test_count = 0
    @@answers = []
  end
  
  def question
    if @@test_count >= 5
      return redirect_to tests_result_url(datas: @datas)
    end
    p "***********"
    if params[:datas].class == String
      params[:datas].split(' ')
    else
      params[:datas].map!(&:to_i)
    end
    p "question"
    p @@test_count
    p @datas = params[:datas]
      if @@test_count == 0
        @data = Definition.find(@datas[@@test_count])
      else
        @data = Definition.find(@datas.try!(:split)[@@test_count])
      end
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
    p @datas = params[:datas].split(' ')
    @answer = @@answers[@@test_count - 1]
    render :answer
  end
  
  def result
    @answers = @@answers
  end
end
