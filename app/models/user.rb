class User < ActiveRecord::Base
	ROLES = %W[admin coin_moderator]

	def roles=(roles)
		self.roles_mask = (roles.map { |r| r.to_s } & ROLES).map { |r| 2 ** ROLES.index(r) }.sum
	end

	def roles
		ROLES.reject { |r| ((roles_mask || 0) & 2 ** ROLES.index(r)).zero? }
	end

	def is?(*required_roles)
		!(roles & required_roles.map { |r| r.to_s }).empty?
	end
end
