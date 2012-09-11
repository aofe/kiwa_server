class InvitationsController < Devise::InvitationsController

	def authenticate_inviter!
	    raise AccessDenied unless params[:secret] == INVITATION_SECRET
	end

end