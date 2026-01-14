# frozen_string_literal: true

module Api
  module V1
    class ClassEnrollmentController < Api::V1::BaseController
      # GET /api/v1/classes/student_class
      def student_classes
        result = ClassEnrollmentService.new.get_enrollments_by_student(@current_user.student_profile.id)
        return render_error result.errors, :unprocessable_entity unless result.success?

        ans = paginate(result.data,
                       { per_page: query_params[:per_page] || 10, page: query_params[:page] || 1 })
        render_success(
          {
            classes: ans[:records].map { |enrollment| ClassEnrollmentSerializer.serialize(enrollment) },
            pagination: ans[:pagination]
          },
          :ok
        )
      end

      # POST /api/v1/classes/:class_id/enroll
      def enroll_class
        result = ClassEnrollmentService.new.enroll(params[:id].to_i, @current_user.student_profile.id)
        if result.success?
          render_success ClassEnrollmentSerializer.serialize(result.data), :created
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      # DELETE /api/v1/classes/:class_id/quit
      def quit_class
        result = ClassEnrollmentService.new.un_enroll(params[:id].to_i, @current_user.student_profile.id)
        if result.success?
          render_success message: 'Successfully quit the class', status: :ok
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      private

      def query_params
        params.permit(:page, :per_page)
      end
    end
  end
end
