Redmine::Plugin.register :redmine_numbering do
  name 'Redmine Numbering plugin'
  author 'Toru Takahashi'
  description 'This is a plugin for Redmine to numbering'
  version '0.0.1'
  url 'https://github.com/torutk/redmine_numbering'
  author_url 'http://02.246.ne.jp/~torutk/'

  project_module :numbering do
    permission :view_numbering_prefix, :numbering_prefixes => [:index]
    permission :manage_numbering_prefix,
           :numbering_prefixes => [:new, :edit, :create, :update, :destroy],
           :require => :member
    permission :view_numbering_item, :numbering_items => [:index, :show]
    permission :manage_numbering_item,
           :numbering_items => [:new, :edit, :create, :update, :destroy, :preview],
           :require => :member
  end

  menu :project_menu, :numbering,
       {:controller => 'numbering_prefixes', :action => 'index'},
       :param => :project_id

end
