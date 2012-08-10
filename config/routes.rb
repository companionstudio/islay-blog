Rails.application.routes.draw do
  scope :module => 'islay_blog' do
    namespace :admin do
      scope :path => 'blog' do
        get '' => 'blog#index', :as => 'blog'

        resources :blog_entries, :path => 'entries' do
          get '(/filter-:filter)(/sort-:sort)', :action => 'index', :as => 'filter_and_sort', :on => :collection
          get 'delete', :on => :member
        end

        resources :blog_comments, :path => 'comments' do
          member do
            get 'delete'
            put 'approve'
            put 'revoke'
          end
        end
      end
    end
  end
end
