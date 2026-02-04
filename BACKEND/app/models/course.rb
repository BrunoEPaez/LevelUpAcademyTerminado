class Course < ApplicationRecord
  # Mantenemos instructor comentado si no hay modelo de Instructor, 
  # pero el campo 'instructor' en la tabla funcionará como String.
  # belongs_to :instructor, optional: true 
  
  # Path es opcional para que los cursos puedan existir sin una ruta específica
  belongs_to :path, optional: true 
  
  # Relaciones con lecciones y estudiantes
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  
  # Soporte para imágenes (Active Storage o URL directa)
  has_one_attached :thumbnail 

  # Validaciones
  validates :title, presence: true
end