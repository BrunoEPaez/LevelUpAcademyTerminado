import React, { useRef } from 'react';
import { CourseCard } from '../components/CourseCard';
import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';

export const PathDetailPage = ({ 
  selectedRoute, 
  courses, 
  completed, 
  toggleFavorite, 
  favorites, 
  navigateTo, 
  setSelectedCourse 
}: any) => {
  const diplomaRef = useRef<HTMLDivElement>(null);

  if (!selectedRoute) return null;

  const routeCourses = selectedRoute.courseIds
    .map((id: number) => courses.find((c: any) => c.id === id))
    .filter(Boolean);


  const doneCount = selectedRoute.courseIds.filter((id: number) => completed.includes(id)).length;
  const progress = Math.round((doneCount / selectedRoute.courseIds.length) * 100);

  const handleLocalDownload = async () => {
    if (!diplomaRef.current) return;
    try {
      const canvas = await html2canvas(diplomaRef.current, { scale: 2 });
      const imgData = canvas.toDataURL('image/png');
      const pdf = new jsPDF({ orientation: 'landscape', unit: 'px', format: [800, 600] });
      pdf.addImage(imgData, 'PNG', 0, 0, 800, 600);
      pdf.save(`Certificado-${selectedRoute.title}.pdf`);
    } catch (error) {
      console.error("Error al generar PDF:", error);
    }
  };

  return (
    <div className="container-center" style={{ padding: '40px 0 100px 0' }}>
      
      {/* --- DIPLOMA OCULTO PARA CAPTURA --- */}
      <div style={{ position: 'absolute', left: '-9999px', top: 0 }}>
        <div ref={diplomaRef} style={{
          width: '800px', height: '600px', padding: '40px', background: 'white',
          border: '20px solid #1e293b', textAlign: 'center', color: '#1e293b', fontFamily: 'serif'
        }}>
          <div style={{ border: '5px solid #fbbf24', height: '100%', padding: '40px', boxSizing: 'border-box' }}>
            <h1 style={{ color: '#fbbf24', fontSize: '40px' }}>LEVELUP ACADEMY</h1>
            <p style={{ fontSize: '20px' }}>CERTIFICADO DE LOGRO PROFESIONAL</p>
            <p style={{ marginTop: '40px' }}>Se otorga a un estudiante de excelencia por completar la ruta:</p>
            <h2 style={{ fontSize: '35px', color: '#1e293b' }}>{selectedRoute.title}</h2>
            <div style={{ marginTop: '60px', borderTop: '1px solid #ccc', paddingTop: '10px' }}>
               <p>ID Verificación: ROUTE-{selectedRoute.id}</p>
               <p>Fecha: {new Date().toLocaleDateString()}</p>
            </div>
          </div>
        </div>
      </div>

      <button 
        onClick={() => navigateTo('categories')} 
        style={{ background: 'rgba(74, 222, 128, 0.1)', border: '1px solid #4ade80', color: '#4ade80', padding: '8px 16px', borderRadius: '8px', cursor: 'pointer', marginBottom: '30px', fontWeight: 'bold' }}
      > ← Volver a Rutas </button>

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '60px', flexWrap: 'wrap', gap: '20px' }}>
        <div style={{ flex: 1 }}>
          <h1 className="white-text" style={{ fontSize: '2.5rem', margin: 0 }}>{selectedRoute.title}</h1>
          <p style={{ color: '#94a3b8', fontSize: '1.1rem', marginTop: '10px', maxWidth: '600px' }}>{selectedRoute.description}</p>
        </div>
        <div style={{ textAlign: 'right', background: '#1e293b', padding: '20px', borderRadius: '15px', border: '1px solid #334155' }}>
          <span style={{ color: 'white', fontSize: '1.2rem', fontWeight: 'bold' }}>{progress}% Completado</span>
          <div style={{ width: '200px', height: '8px', background: '#0f172a', borderRadius: '10px', marginTop: '10px', overflow: 'hidden' }}>
            <div style={{ width: `${progress}%`, height: '100%', background: '#4ade80', transition: 'width 1s ease' }} />
          </div>
        </div>
      </div>

      <div className="vertical-path" style={{ maxWidth: '700px', margin: '0 auto' }}>
        {routeCourses.map((c: any, index: number) => {
          const isDone = completed.includes(c.id);
          return (
            <div key={c.id} style={{ display: 'flex', gap: '30px', position: 'relative' }}>
               <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '50px' }}>
                  <div style={{ 
                    width: '40px', height: '40px', borderRadius: '50%', 
                    background: isDone ? '#4ade80' : '#1e293b', color: isDone ? '#0f172a' : '#94a3b8',
                    display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 2, fontWeight: 'bold', border: isDone ? 'none' : '2px solid #334155'
                  }}> {isDone ? '✓' : index + 1} </div>
                  {index !== routeCourses.length - 1 && (
                    <div style={{ width: '2px', height: '180px', background: isDone ? '#4ade80' : '#334155' }} />
                  )}
               </div>
               <div style={{ flexGrow: 1, maxWidth: '450px', marginBottom: '40px', transform: isDone ? 'scale(0.98)' : 'scale(1)', opacity: isDone ? 0.8 : 1, transition: 'all 0.3s ease' }}>
                  <div className="mini-card-wrapper" style={{ cursor: 'pointer' }}>
                    <CourseCard 
                      course={c} isFavorite={favorites.includes(c.id)} onFavorite={toggleFavorite} 
                      onClick={() => { setSelectedCourse(c); navigateTo('course-detail'); }} 
                    />
                  </div>
               </div>
            </div>
          );
        })}
      </div>

      {progress === 100 && (
        <div style={{ padding: '50px', textAlign: 'center', background: 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)', borderRadius: '24px', marginTop: '60px', border: '2px solid #fbbf24', boxShadow: '0 10px 40px rgba(251, 191, 36, 0.2)' }}>
          <h2 style={{ color: '#fbbf24', fontSize: '2.2rem', marginBottom: '10px' }}>🏆 ¡RUTA COMPLETADA!</h2>
          <div style={{ margin: '30px auto', padding: '30px', maxWidth: '500px', background: 'white', borderRadius: '10px', color: '#1a1a2e', border: '8px double #fbbf24', position: 'relative' }}>
            <h3 style={{ margin: 0, fontSize: '1.5rem', fontFamily: 'serif' }}>CERTIFICADO DE LOGRO</h3>
            <p style={{ margin: '10px 0' }}>Se otorga a:</p>
            <h4 style={{ fontSize: '1.8rem', borderBottom: '1px solid #ccc', display: 'inline-block', padding: '0 20px' }}>Estudiante</h4>
            <p>Por haber completado con éxito la especialización en:</p>
            <strong style={{ fontSize: '1.3rem', color: '#d97706' }}>{selectedRoute.title}</strong>
          </div>
          <p style={{ color: '#94a3b8' }}>Este diploma ya está disponible permanentemente en tu perfil.</p>
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '20px', marginTop: '20px' }}>
            <button onClick={handleLocalDownload} style={{ padding: '15px 45px', background: '#fbbf24', color: '#000', border: 'none', borderRadius: '10px', fontWeight: '900', cursor: 'pointer', fontSize: '1.1rem', boxShadow: '0 4px 15px rgba(251, 191, 36, 0.4)' }}>
              📥 Descargar Título Oficial (PDF)
            </button>
            <button onClick={() => { sessionStorage.setItem('dashboard_tab', 'certificates'); navigateTo('dashboard'); }} style={{ background: 'none', color: '#94a3b8', border: '1px solid #334155', padding: '10px 25px', borderRadius: '8px', cursor: 'pointer' }}>
              Ver todos mis Certificados
            </button>
          </div>
        </div>
      )}
    </div>
  );
};