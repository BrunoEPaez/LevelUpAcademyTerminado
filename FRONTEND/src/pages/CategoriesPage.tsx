import { useState } from 'react';
import { ACADEMY_DATA } from '../data/routesData';

export const CategoriesPage = ({ completed, navigateTo, setSelectedRoute }: any) => {
  const categories = Object.keys(ACADEMY_DATA);
  const [activeCat, setActiveCat] = useState(categories[0]);

  const subRoutes = ACADEMY_DATA[activeCat as keyof typeof ACADEMY_DATA];

  return (
    <div className="container-center" style={{ marginTop: '40px' }}>
      <header style={{ marginBottom: '40px' }}>
        <h1 className="white-text">Rutas de Especialización</h1>
        <p style={{ color: '#94a3b8' }}>Elige una especialidad para comenzar tu camino.</p>
      </header>

      <div className="explorer-layout-fixed" style={{ display: 'grid', gridTemplateColumns: '280px 1fr', gap: '30px' }}>
        <aside className="sidebar-facilito">
          {categories.map(cat => (
            <button 
              key={cat} 
              className={`category-item-btn ${activeCat === cat ? 'active' : ''}`}
              onClick={() => setActiveCat(cat)}
            >
              {cat}
            </button>
          ))}
        </aside>

        <main style={{ 
  display: 'grid', 
  gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', // Columnas más estrechas
  gap: '20px' 
}}>
  {subRoutes.map(route => {
    const done = route.courseIds.filter((id: number) => completed.includes(id)).length;
    const progress = Math.round((done / route.courseIds.length) * 100);

    return (
      <div 
        key={route.id}
        onClick={() => {
          setSelectedRoute(route);
          navigateTo('path-detail', route);
        }}
        className="route-card-premium"
        style={{
          background: '#1e293b',
          borderRadius: '12px', // Bordes más finos
          overflow: 'hidden',
          cursor: 'pointer',
          border: '1px solid #334155',
          transition: 'all 0.3s ease',
          boxShadow: '0 4px 6px rgba(0,0,0,0.1)'
        }}
      >
        {/* Imagen más pequeña (proporción 16:9 ajustada) */}
        <div style={{ 
          height: '130px', 
          background: `url(${route.image}) center/cover`,
          borderBottom: '1px solid #334155'
        }} />
        
        <div style={{ padding: '15px' }}>
          <h4 className="white-text" style={{ margin: 0, fontSize: '1rem' }}>{route.title}</h4>
          <p style={{ 
            color: '#94a3b8', 
            fontSize: '0.75rem', 
            margin: '8px 0',
            display: '-webkit-box',
            WebkitLineClamp: 2,
            WebkitBoxOrient: 'vertical',
            overflow: 'hidden'
          }}>
            {route.description}
          </p>
          
          <div style={{ marginTop: '12px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', color: route.color, marginBottom: '4px' }}>
              <span style={{fontWeight: 'bold'}}>Progreso</span>
              <span>{progress}%</span>
            </div>
            <div style={{ height: '4px', background: '#0f172a', borderRadius: '10px' }}>
              <div style={{ 
                width: `${progress}%`, 
                height: '100%', 
                background: route.color, 
                borderRadius: '10px', 
                boxShadow: `0 0 8px ${route.color}66`
              }} />
            </div>
          </div>
        </div>
      </div>
    );
  })}
</main>
      </div>
    </div>
  );
};