class TestsController < ApplicationController

  def start
    p "start"
    @total_count = 0
    @datas = []
  end
  
  def question
    p "question"
    p @total_count = params[:total_count].try(:to_i) || 0
    p @datas = params[:datas] || []
    p @answers = params[:answers] || []
    if @answers.class == String
      @answers.split(',')
    end
    p @answers
    if params[:type].present? && params[:type] == "個人定義帳"
      @type = params[:type]
      definitions = current_user.favorite_definitions
      definitions_without_memories(definitions)
    elsif params[:type].present?
      @type = params[:type]
      definitions = Definition.where(category_id: Category.find_by(name: @type)) || Definition.all
      definitions_without_memories(definitions)
    else
      definitions = Definition.where(user_id: referenceable_ids)
      definitions_without_memories(definitions)
    end

    p count = definitions.count
    if count == 0
      flash[:success] = "該当する問題がありませんでした。"
      return redirect_to tests_start_url
    end
    @datas = definitions.pluck(:id) || params[:datas]
    if @total_count >= count
      return redirect_to tests_result_url(datas: @datas, answers: @answers)
    end

    @definition = Definition.find(@datas[@total_count])
    @user_definition = UserDefinition.find_by(definition_id: @definition.id)
  end
  
  def post_answer
    p "post_answer"
    p @total_count = params[:total_count].try(:to_i) || 0
    p @datas = params[:datas] || []
    p @answers = params[:answers] || []
    @answer.try(:split)
    if @answers.class == String
      answer = @answers
      @answers = []
      @answers << answer
      @answers.pop if @total_count == 0
    end
    @total_count += 1
    @datas = params[:datas]
    @answer = params[:test][:answer]
    @answers << @answer
    redirect_to tests_answer_path(datas: @datas, type: params[:type], total_count: @total_count, answers: @answers)
  end

  def get_answer
    p "get_answer"
    p @total_count = params[:total_count].try(:to_i) || 0
    p @datas = params[:datas] || []
    p @answers = params[:answers] || []
    @type = params[:type]
    if params[:datas].class == String
      @datas = params[:datas].split(' ')
    else
      @datas = params[:datas]
    end

    if @total_count == 1
      @definition =  Definition.find(@datas[0])
    else
      @definition =  Definition.find(@datas[@total_count - 1])
    end
    
    @user_definition = UserDefinition.find_by(definition_id: @datas[@total_count - 1])
    @answer = @answers[@total_count - 1]
    render :answer
  end
  
  def result
    p @answers = params[:answers].split(' ')
    p @datas = params[:datas].map!(&:to_i)
  end
  
  private
  
  def definitions_without_memories(definitions)
    definition_keys = definitions.pluck(:id)  
    memory_keys = Memory.where(definition_id: definition_keys).pluck(:definition_id)
    definition_keys.delete_if {|id| memory_keys.include?(id)}
    @definitions = Definition.where(id: definition_keys)
  end
end
