class TasksController < ApplicationController

  # :indexと:showのアクションはログインが必要
  before_action :require_user_logged_in
    # before_actioは、アクション実行前に前もって実行するメソッド
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # 削除アクション前にユーザーが所有しているかの確認
  before_action :correct_user, only: [:destroy]
  def index
  
      # タスク一覧表示 ページネーション３
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    # 入力フォーム用
      @task = current_user.tasks.build
  end

  def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
          flash[:success] = 'タスクが正常に投稿されました'
          redirect_to root_url
      else
          flash.now[:danger] = 'タスクが投稿されませんでした'
          render :new
      end
  end

  def edit
  end

  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されました'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  def set_task
     @task = Task.find(params[:id])
  end
  
  
  def task_params
     params.require(:task).permit(:content, :status)
  end
  
  
  # 削除するタスクが本当にログインユーザーが所有しているか確認
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    # @taskがない場合、root_urlに戻る
    unless @task
      redirect_to root_url
    end
  end
end
