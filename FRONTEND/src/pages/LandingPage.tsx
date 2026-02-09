import { useRef } from 'react';
import { CourseCard } from '../components/CourseCard';

const CarouselSection = ({ title, courses, favorites, toggleFavorite, navigateTo, setSelectedCourse }: any) => {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: 'left' | 'right') => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const moveAmount = clientWidth * 0.8;
      scrollRef.current.scrollTo({
        left: direction === 'left' ? scrollLeft - moveAmount : scrollLeft + moveAmount,
        behavior: 'smooth'
      });
    }
  };

  if (courses.length === 0) return null;

  return (
    <section className="container-center" style={{ padding: '40px 0' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
        <h2 className="white-text" style={{ margin: 0 }}>{title}</h2>
        <div style={{ display: 'flex', gap: '10px' }}>
          <button className="nav-btn-home" onClick={() => scroll('left')}>❮</button>
          <button className="nav-btn-home" onClick={() => scroll('right')}>❯</button>
        </div>
      </div>
      
      <div className="home-carousel-container" ref={scrollRef}>
        {courses.map((c: any) => (
          <div key={c.id} className="home-carousel-item">
            <CourseCard 
              course={c} 
              isFavorite={favorites.includes(c.id)} 
              onFavorite={toggleFavorite} 
              onClick={() => { setSelectedCourse(c); navigateTo('course-detail'); }} 
            />
          </div>
        ))}
      </div>
    </section>
  );
};

export const LandingPage = ({ courses, favorites, toggleFavorite, navigateTo, setSelectedCourse }: any) => {
  
  // 1. Cursos Populares: Los primeros 10 de la lista original
  const popularCourses = courses.slice(0, 10);

  // 2. Nuevos Cursos: Invertimos la lista para mostrar los últimos agregados
  const newCourses = [...courses].reverse().slice(0, 10);

  // 3. Cursos Gratuitos: Filtra por propiedad isFree o price 0
  // IMPORTANTE: Asegúrate de que en tus datos algunos cursos tengan { isFree: true }
  const freeCourses = courses.filter((c: any) => 
    c.isFree === true || c.price === 0 || c.category === 'Gratis'
  );

  // 4. Cursos de Frontend (Extra): Por si quieres mantener la categoría
  const frontendCourses = courses.filter((c: any) => 
    c.title.toLowerCase().includes('react') || 
    c.title.toLowerCase().includes('frontend')
  ).slice(0, 10);

  return (
    <div className="landing-wrapper">
      <header className="hero-education">
        <div className="container-center">
          <h1>Domina las <span className="text-gradient">Tecnologías</span> del Futuro</h1>
          <p>Aprende de expertos con rutas guiadas y proyectos reales.</p>
          <div style={{ display: 'flex', gap: '15px', justifyContent: 'center', marginTop: '40px' }}>
            <button className="btn-primary-levelup" onClick={() => navigateTo('explorer')}>
              Ver todos los cursos
            </button>
          </div>
        </div>
      </header>

      {/* SECCIÓN: POPULARES */}
      <CarouselSection 
        title="🚀 Cursos más demandados" 
        courses={popularCourses} 
        favorites={favorites} 
        toggleFavorite={toggleFavorite} 
        navigateTo={navigateTo} 
        setSelectedCourse={setSelectedCourse} 
      />

      {/* SECCIÓN: NUEVOS CURSOS (Los últimos añadidos) */}
      <CarouselSection 
        title="✨ Nuevos Lanzamientos" 
        courses={newCourses} 
        favorites={favorites} 
        toggleFavorite={toggleFavorite} 
        navigateTo={navigateTo} 
        setSelectedCourse={setSelectedCourse} 
      />

      {/* SECCIÓN: GRATUITOS */}
      {freeCourses.length > 0 ? (
        <CarouselSection 
          title="🎁 Cursos Gratuitos" 
          courses={freeCourses} 
          favorites={favorites} 
          toggleFavorite={toggleFavorite} 
          navigateTo={navigateTo} 
          setSelectedCourse={setSelectedCourse} 
        />
      ) : (
        /* Si no hay cursos con isFree: true, mostramos un aviso elegante */
        <section className="container-center" style={{ padding: '40px 0' }}>
          <div style={{ 
            background: 'rgba(74, 222, 128, 0.05)', 
            border: '1px dashed #4ade80', 
            padding: '30px', 
            borderRadius: '20px', 
            textAlign: 'center' 
          }}>
            <h3 style={{ color: '#4ade80', margin: 0 }}>🎁 Próximamente: Cursos Gratuitos</h3>
            <p style={{ color: '#94a3b8' }}>Estamos preparando contenido gratuito para ti. ¡Mantente atento!</p>
          </div>
        </section>
      )}

      {/* SECCIÓN: FRONTEND (Opcional) */}
      {frontendCourses.length > 0 && (
        <CarouselSection 
          title="💻 Especialización Frontend" 
          courses={frontendCourses} 
          favorites={favorites} 
          toggleFavorite={toggleFavorite} 
          navigateTo={navigateTo} 
          setSelectedCourse={setSelectedCourse} 
        />
      )}
    </div>
  );
};