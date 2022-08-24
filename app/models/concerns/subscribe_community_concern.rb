module SubscribeCommunityConcern
  extend ActiveSupport::Concern

  def subscribed_communities
    communities
  end

  # @param [community] community or the community id
  def subscribe!(community)
    community = Community.find(community) if community.is_a?(Integer)
    communities << community

    save!
  end

  # @param [community] community or the community id
  def subscribe?(community)
    community = Community.find(community) if community.is_a?(Integer)
    communities.include?(community)
  end

  # @param [community] community or the community id
  def unsubscribe!(community)
    community = Community.find(community) if community.is_a?(Integer)
    communities.delete(community)

    save!
  end
end
