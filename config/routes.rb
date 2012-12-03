Rails.application.routes.draw do
  islay_admin 'islay_blog' do
    scope :path => 'blog' do
      get '' => 'blog#index', :as => 'blog'

      resources :blog_entries, :path => 'entries' do
        get '(/filter-:filter)(/sort-:sort)', :action => 'index', :as => 'filter_and_sort', :on => :collection
        get 'delete', :on => :member
      end

      resources :blog_comments, :path => 'comments', :only => %w(destroy) do
        get 'delete', :on => :member
      end

      resources :blog_tags, :path => 'tags', :only => %w(index show)
    end
  end

  islay_public 'islay_blog' do
    scope :path => 'blog', :controller => 'blog' do
      get  '/(page-:page)', :action => 'index',   :as => 'blog'
      get  '/:id',          :action => 'entry',   :as => 'blog_entry'
      post '/:id/comment',  :action => 'comment', :as => 'blog_comment'
      get  '/tag/:id',      :action => 'tag',     :as => 'blog_tag'
    end
  end
end
