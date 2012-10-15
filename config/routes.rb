Rails.application.routes.draw do
  scope :module => 'islay_blog' do
    namespace :admin do
      scope :path => 'blog' do
        get '' => 'blog#index', :as => 'blog'

        resources :blog_entries, :path => 'entries' do
          get '(/filter-:filter)(/sort-:sort)', :action => 'index', :as => 'filter_and_sort', :on => :collection
          get 'delete', :on => :member
        end

        resources :blog_comments, :path => 'comments', :only => %w(index show destroy) do
          member do
            get 'delete'
            put 'approve'
            put 'revoke'
          end
        end

        resources :blog_tags, :path => 'tags', :only => %w(index show)
      end
    end

    namespace :public, :path => '' do
      scope :path => 'blog', :controller => 'blog' do
        get  '/(page-:page)', :action => 'index',   :as => 'blog'
        get  '/:id',          :action => 'entry',   :as => 'blog_entry'
        post '/:id/comment',  :action => 'comment', :as => 'blog_comment'
        get  '/tag/:id',      :action => 'tag',     :as => 'blog_tag'
      end
    end
  end
end
