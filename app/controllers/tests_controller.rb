class TestsController < ApplicationController
  @@test_count = 0
  @@answers = []

  def start
    p "start"
    p @@test_count
    @datas = Definition.all.sample(5)
    @@test_count = 0
    @@answers = []
  end
  
  def question
    p "start"
    p @@test_count
    p @datas = params[:datas]
    p @data = Definition.find(params[:datas][@@test_count].to_i)
  end
  
  def answer
    @@test_count += 1
    p "start"
    p @@test_count
    p @datas = params[:datas].split(' ')
    p @answer = params[:test][:answer]
    p @@answers << @answer
    if @@test_count >= 5
      redirect_to tests_result_url(datas: @datas)
    else
      redirect_to tests_question_url(datas: @datas)
    end
  end
  
  def result
    @answers = @@answers
  end
end
