# frozen_string_literal: true

module Api
  module V1
    class LeaveRequestsController < Api::V1::BaseController
      before_action :set_leave_request, only: %i[show update destroy approve reject]

      # GET /api/v1/classes/:class_id/leave_requests
      def index
        result = leave_request_service.by_student(current_student_id)
        return render_error(result.errors, :unprocessable_entity) if result.failure?

        leave_requests = result.data
        leave_requests = leave_requests.where(status: query_params[:status]) if query_params[:status].present?

        paginated = paginate(
          leave_requests,
          per_page: query_params[:per_page] || 10,
          page: query_params[:page] || 1
        )

        render_success(
          {
            leave_requests: LeaveRequestSerializer.serialize_collection(paginated[:records]),
            pagination: paginated[:pagination]
          },
          :ok
        )
      end

      # GET /api/v1/leave_requests/:id
      def show
        render_success(LeaveRequestSerializer.serialize(@leave_request))
      end

      # POST /api/v1/classes/:class_id/leave_requests
      def create
        result = leave_request_service.create(leave_request_params)

        if result.success?
          render_success(
            LeaveRequestSerializer.serialize(result.data),
            :created
          )
        else
          render_error(result.errors, :unprocessable_entity)
        end
      end

      # PATCH/PUT /api/v1/leave_requests/:id
      def update
        result = leave_request_service.update(@leave_request, leave_request_params)

        if result.success?
          render_success(LeaveRequestSerializer.serialize(result.data))
        else
          render_error(result.errors, :unprocessable_entity)
        end
      end

      # DELETE /api/v1/leave_requests/:id
      def destroy
        result = leave_request_service.destroy(@leave_request)

        if result.failure?
          render_error(result.errors, :unprocessable_entity)
        else
          render_success(
            { message: 'Leave request deleted successfully' },
            :no_content
          )
        end
      end

      # PATCH /api/v1/leave_requests/:id/approve
      def approve
        handle_status_change(:approve)
      end

      # PATCH /api/v1/leave_requests/:id/reject
      def reject
        handle_status_change(:reject)
      end

      private


      def set_leave_request
        @leave_request = LeaveRequest.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error('Leave request not found', :not_found)
      end

      def leave_request_service
        @leave_request_service ||= LeaveRequestService.new(
          current_student_id,
          params[:class_id]
        )
      end


      def handle_status_change(action)
        if action == :approve
          result = leave_request_service.approve(@leave_request)
        else
          result = leave_request_service.reject(@leave_request)
        end
        if result.success?
          render_success(LeaveRequestSerializer.serialize(result.data))
        else
          render_error(result.errors, :unprocessable_entity)
        end
      end

      def current_student_id
        @current_user.student_profile.id
      end

      def leave_request_params
        params.require(:leave_request).permit(
          :date,
          :reason,
          :status,
          :teacher_note,
          :leave_type
        )
      end

      def query_params
        params.permit(:page, :per_page, :status)
      end
    end
  end
end
