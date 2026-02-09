import React, { useEffect, useState } from 'react';
import { CourseCard } from '../components/CourseCard';

// 1. Definimos la interfaz para que TypeScript no de error al recibir props de App.tsx
interface CoursesPageProps {
  courses?: any[];           // El ? significa que es opcional
  favorites: number[];
  toggleFavorite: (e: React.MouseEvent, course: any) => void;
  navigateTo: (view: string) => void;
  setSelectedCourse: (course: any) => void;
}

// 2. Aplicamos la interfaz al componente
export const CoursesPage: React.FC<CoursesPageProps> = ({ 
  courses: initialCourses, 
  favorites, 
  toggleFavorite, 
  navigateTo, 
  setSelectedCourse 
}) => {
  const [courses, setCourses] = useState<any[]>(initialCourses || []);
  const [loading, setLoading] = useState(!initialCourses || initialCourses.length === 0);

  useEffect(() => {
    // Solo hace el fetch si no vienen cursos desde las props
    if (!initialCourses || initialCourses.length === 0) {
      fetch('https://levelupacademyterminado.onrender.com/api/courses')
        .then((res) => res.json())
        .then((data) => {
          setCourses(data);
          setLoading(false);
        })
        .catch((err) => {
          console.error("Error conectando con Rails:", err);
          setLoading(false);
        });
    }
  }, [initialCourses]);

  if (loading) {
    return (
      <div style={{ color: 'white', textAlign: 'center', marginTop: '100px' }}>
        Cargando cursos de Dalto...
      </div>
    );
  }

  return (
    <div style={{ backgroundColor: '#0f172a', minHeight: '100vh', padding: '40px' }}>
      <h1 style={{ color: 'white', textAlign: 'center', marginBottom: '40px', fontSize: '2.5rem' }}>
        Cursos de Soy Dalto
      </h1>
      
      {/* Contenedor Grid responsivo */}
      <div style={{ 
        display: 'grid', 
        gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', 
        gap: '20px',
        maxWidth: '1200px',
        margin: '0 auto'
      }}>
        {courses.map((course: any) => (
          <CourseCard 
            key={course.id} 
            course={course} 
            // Usamos las funciones reales que vienen de App.tsx
            onClick={() => {
              setSelectedCourse(course);
              navigateTo('course-detail');
            }}
            onFavorite={(e) => toggleFavorite(e, course)}
            isFavorite={favorites.includes(course.id)}
          />
        ))}
      </div>
    </div>
  );
};