import React, { useEffect, useState } from 'react';
import { CourseCard } from '../components/CourseCard';

export const CoursesPage: React.FC = () => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // IMPORTANTE: Asegúrate de que tu Rails esté corriendo en el puerto 3000
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
  }, []);

  if (loading) return <div style={{color: 'white', textAlign: 'center', marginTop: '100px'}}>Cargando cursos de Dalto...</div>;

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
            onClick={() => console.log("Click en:", course.title)}
            onFavorite={() => console.log("Like en:", course.id)}
            isFavorite={false}
          />
        ))}
      </div>
    </div>
  );
};