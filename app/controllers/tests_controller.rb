class TestsController < ApplicationController
  @@test_count = 0
  @@answers = []

  def start
    p "start"
    p @@test_count
    # definitions = Definition.all
    # all_datas = definitions.sample(definitions.count)
    # p @datas = all_datas.pluck(:id).join(' ')
    @@test_count = 0
    @@answers = []
  end
  
  def question
    if params[:type]
      @type = params[:type]
      @definitions = Definition.where(category_id: Category.find_by(name: @type))
      count = @definitions.count
    else
      @definitions = Definition.all
      count = @definitions.count
    end
    p @datas = @definitions.pluck(:id)
    if @@test_count >= count
      return redirect_to tests_result_url(datas: @datas)
    end
    p "question"
    p "definitions_count #{count}"
    p params
    p @@test_count
    p @definition = Definition.find(@datas[@@test_count])
      @user_definition = UserDefinition.find_by(definition_id: @datas[@@test_count])
  end
  
  def post_answer
    @@test_count += 1
    p "post_answer"
    p params[:type]
    p @@test_count
    p @datas = params[:datas].split(' ')
    p @answer = params[:test][:answer]
    p @@answers << @answer
    redirect_to tests_answer_path(datas: @datas, type: params[:type])
  end
  
  def get_answer
    @type = params[:type]
    p @@test_count
    p "get_answer"
    p params
     p @datas = params[:datas]
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
