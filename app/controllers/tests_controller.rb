class TestsController < ApplicationController
  @@test_count = 0

  def start
    @@test_count = 0
    p "start"
    p @@test_count
  end
  
  def question
    p "start"
    p @@test_count
  end
  
  def answer
    @@test_count += 1
    p "start"
    p @@test_count
    if @@test_count >= 5
      redirect_to tests_result_url
    else
      redirect_to tests_question_url
    end
  end
  
  def result
  end
end
