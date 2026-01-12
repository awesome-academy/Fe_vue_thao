# frozen_string_literal: true

class CustomError < StandardError; end

class NotFoundError < CustomError; end

class UnauthorizedError < CustomError; end

class ForbiddenError < CustomError; end

class ValidationError < CustomError; end

class BadRequestError < CustomError; end
