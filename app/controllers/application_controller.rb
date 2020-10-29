class ApplicationController < ActionController::Base
    
    # Controller から Helper のメソッドを使うことはデフォルトではできない
    include SessionsHelper
    
    private
    
    # 全てのコントローラーで定義したメソッドが使用可能
    def require_user_logged_in
    # ログインしていなければ、ログインページに移動
        unless logged_in?
            redirect_to login_url
        end
    end
end
