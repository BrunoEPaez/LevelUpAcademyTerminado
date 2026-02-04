class User < ApplicationRecord
  # Devise maneja la autenticación.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :email, presence: true, uniqueness: true
         
  # Relaciones heredadas de la base de Empleos
  has_many :jobs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_jobs, through: :favorites, source: :job
  has_many :applications, dependent: :destroy
  has_many :applied_jobs, through: :applications, source: :job

  # Relaciones específicas de LevelUpAcademy
  has_many :taught_courses, class_name: 'Course', foreign_key: 'instructor_id'
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :progresses, dependent: :destroy
end