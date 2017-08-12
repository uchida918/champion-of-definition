class TestsController < ApplicationController
  @@test_count = 0
  @@answers = []

  def start
    p "start"
    @@test_count = 0
    @@answers = []
  end
  
  def question
    p "question"
    if params[:type].present?
      @type = params[:type]
      @definitions = Definition.where(category_id: Category.find_by(name: @type)) || Definition.all
      count = @definitions.count
    else
      @definitions = Definition.all
      count = @definitions.count
    end
    @datas = @definitions.pluck(:id) or params[:datas]
    if @@test_count >= count
      return redirect_to tests_result_url(datas: @datas)
    end

    @definition = Definition.find(@datas[@@test_count])
    @user_definition = UserDefinition.find_by(definition_id: @datas[@@test_count])
  end
  
  def post_answer
    p "post_answer"
    @@test_count += 1
    @datas = params[:datas]
    @answer = params[:test][:answer]
    @@answers << @answer
    redirect_to tests_answer_path(datas: @datas, type: params[:type])
  end
  
  def get_answer
    p "get_answer"
    @type = params[:type]
    if params[:datas].class == String
      @datas = params[:datas].split(' ')
    else
      @datas = params[:datas]
    end

    if @@test_count == 1
      @definition =  Definition.find(@datas[0])
    else
      @definition =  Definition.find(@datas[@@test_count - 1])
    end
    
    @user_definition = UserDefinition.find_by(definition_id: @datas[@@test_count - 1])
    @answer = @@answers[@@test_count - 1]
    render :answer
  end
  
  def result
    p @answers = @@answers
    p @datas = params[:datas].map!(&:to_i)
  end
end
