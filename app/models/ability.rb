class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    
    can [:show_country, :show_nominal, :show_year], :coin

    if user.is? :admin then
      can :manage, :all
    end

    if user.is? :coin_moderator then
      can :update, :coin
    end
  end
end
