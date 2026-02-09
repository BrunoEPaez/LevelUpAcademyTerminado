# db/seeds.rb
puts "Iniciando limpieza de base de datos..."

# Usamos SQL puro para limpiar tablas y evitar errores si 'enrollments' no existe en el modelo
begin
  ActiveRecord::Base.connection.execute("TRUNCATE courses, paths, lessons CASCADE")
  puts "Tablas limpiadas con éxito."
rescue => e
  puts "Aviso: No se pudo realizar el truncate (quizás las tablas aún no existen): #{e.message}"
end

# 1. Creamos el Path por defecto
# Usamos find_or_create_by para evitar duplicados si el script se corre varias veces
default_path = Path.find_or_create_by!(id: 1) do |p|
  p.title = "Camino Principal"
end

# 2. Definición del método para agregar cursos y sus lecciones
def add_course(category, title, author, url, path_id)
  # Extraer el ID del video de YouTube de forma segura
  begin
    video_id = url.split('v=').last.split('&').first
  rescue
    video_id = "dQw4w9WgXcQ" # Video por defecto si falla la URL
  end

  # Crear el curso
  course = Course.create!(
    title: title,
    description: "Curso completo de #{title} dictado por #{author}. Disponible en YouTube.",
    thumbnail_url: "https://img.youtube.com/vi/#{video_id}/maxresdefault.jpg",
    youtube_id: video_id,
    category: category,
    instructor: author,
    path_id: path_id
  )

  # IMPORTANTE: Crear la lección vinculada. 
  # Esto arregla el Error 500 en /api/progress y permite que cada curso tenga su video.
  Lesson.create!(
    course_id: course.id,
    youtube_id: video_id,
    title: "Clase Completa: #{title}",
    position: 1
  )
end

puts "Cargando cursos masivos por categorías..."

# --- DESARROLLO WEB ---
add_course('Desarrollo web', 'HTML y CSS desde CERO', 'Soy Dalto', 'https://www.youtube.com/watch?v=ELSm-G201Ls', default_path.id)
add_course('Desarrollo web', 'JAVASCRIPT Master', 'Soy Dalto', 'https://www.youtube.com/watch?v=EbMi1Qj4rVE', default_path.id)
add_course('Desarrollo web', 'JAVASCRIPT MID LEVEL', 'Soy Dalto', 'https://www.youtube.com/watch?v=xOinGb2MZSk', default_path.id)
add_course('Desarrollo web', 'JAVASCRIPT JUNIOR', 'Soy Dalto', 'https://www.youtube.com/watch?v=z95mZVUcJ-E', default_path.id)
add_course('Desarrollo web', 'JAVA desde cero + Spring + Docker', 'Sergie Code', 'https://www.youtube.com/watch?v=BdNqW63ZaB0', default_path.id)
add_course('Desarrollo web', 'NODE JS desde cero + Express', 'Sergie Code', 'https://www.youtube.com/watch?v=I17ln313Pjk', default_path.id)
add_course('Desarrollo web', 'ANGULAR desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=soInCF7nbDw', default_path.id)
add_course('Desarrollo web', 'REACT JS desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=ladwC6Lrs-M', default_path.id)
add_course('Desarrollo web', 'JAVASCRIPT desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=N8Xt5rP_DUo', default_path.id)
add_course('Desarrollo web', 'CSS desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=rTtC6Q-71qg', default_path.id)
add_course('Desarrollo web', 'HTML desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=bNV6iw13Rnk', default_path.id)
add_course('Desarrollo web', 'Ruby y Ruby on Rails', 'Informatica Live', 'https://www.youtube.com/watch?v=ulBNEtVhSBc', default_path.id)
add_course('Desarrollo web', 'NODE JS Completo', 'Informatica Live', 'https://www.youtube.com/watch?v=rChMxLLNo5s', default_path.id)
add_course('Desarrollo web', 'TAILWIND CSS DESDE 0', 'Informatica Live', 'https://www.youtube.com/watch?v=ab3a6Po98TI', default_path.id)
add_course('Desarrollo web', 'PHP COMPLETO', 'Informatica Live', 'https://www.youtube.com/watch?v=MEpnkPBqS2k', default_path.id)
add_course('Desarrollo web', 'Vue - Curso COMPLETO', 'AMazaing Code', 'https://www.youtube.com/watch?v=KdfrY2GYuTo', default_path.id)
add_course('Desarrollo web', 'Angular - Curso COMPLETO', 'AMazaing Code', 'https://www.youtube.com/watch?v=l8oOg5CiNO8', default_path.id)
add_course('Desarrollo web', 'React - Curso COMPLETO', 'AMazaing Code', 'https://www.youtube.com/watch?v=vH1u6Xv6oXw', default_path.id)
add_course('Desarrollo web', 'Crea WEB (HTML+CSS+JS)', 'Sinergia', 'https://www.youtube.com/watch?v=4jbAdT9_htI', default_path.id)
add_course('Desarrollo web', 'BOOTSTRAP desde CERO', 'Sinergia', 'https://www.youtube.com/watch?v=kLBlM3yF2-A', default_path.id)
add_course('Desarrollo web', 'JAVASCRIPT INTERMEDIO', 'MoureDev', 'https://www.youtube.com/watch?v=6T3XKYWPD6c', default_path.id)
add_course('Desarrollo web', 'PYTHON para WEB Avanzado', 'MoureDev', 'https://www.youtube.com/watch?v=bNy8OZJfA6I', default_path.id)
add_course('Desarrollo web', 'REACT 19 Full Curso 2025', 'Codigo 369', 'https://www.youtube.com/watch?v=m0soI9MQ4Dg', default_path.id)
add_course('Desarrollo web', 'Sistema de Ventas REACT + Postgres', 'Codigo 369', 'https://www.youtube.com/watch?v=URG4rnmdThs', default_path.id)
add_course('Desarrollo web', 'Tailwind CSS v4 (2025)', 'Codigo 369', 'https://www.youtube.com/watch?v=h6xQCE6J1VQ', default_path.id)
add_course('Desarrollo web', 'TanStack y Zustand Para REACT', 'Codigo 369', 'https://www.youtube.com/watch?v=1_dj9Stack', default_path.id)
add_course('Desarrollo web', 'Control de INVENTARIOS React', 'Codigo 369', 'https://www.youtube.com/watch?v=jLMIMgwgLLw', default_path.id)
add_course('Desarrollo web', 'Control de Gastos React', 'Codigo 369', 'https://www.youtube.com/watch?v=xnFhaVTgGGs', default_path.id)
add_course('Desarrollo web', 'REACT 0 a EXPERTO', 'Gentleman Programming', 'https://www.youtube.com/watch?v=GMnWXlJnbNo', default_path.id)
add_course('Desarrollo web', 'Angular 0 a EXPERTO 2025', 'Gentleman Programming', 'https://www.youtube.com/watch?v=R1QePsia5xk', default_path.id)
add_course('Desarrollo web', 'Tailwind CSS - Curso Completo', 'freeCodeCamp', 'https://www.youtube.com/watch?v=5HtRcMSO1Ro', default_path.id)
add_course('Desarrollo web', 'CSS Flexbox - Curso desde Cero', 'freeCodeCamp', 'https://www.youtube.com/watch?v=iwFEc6I8wSA', default_path.id)
add_course('Desarrollo web', 'DISEÑO WEB (Completo)', 'soesve', 'https://www.youtube.com/watch?v=RfS_a70WYQ0', default_path.id)
add_course('Desarrollo web', 'WordPress: Crear BLOG', 'soesve', 'https://www.youtube.com/watch?v=PJiveUtZ3Ww', default_path.id)
add_course('Desarrollo web', 'WORDPRESS GRATIS', 'soesve', 'https://www.youtube.com/watch?v=EyEtJHqzgnE', default_path.id)
add_course('Desarrollo web', 'Desarrollo Web con IA', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=ttGGQlj_Aqs', default_path.id)

# --- DESARROLLO MÓVIL ---
add_course('Desarrollo móvil', 'FLUTTER y DART desde CERO', 'AristiDevs', 'https://www.youtube.com/watch?v=IKG1eV2SetA', default_path.id)
add_course('Desarrollo móvil', 'SWIFT y SWIFTUI desde CERO', 'AristiDevs', 'https://www.youtube.com/watch?v=f6WtmTBFNGM', default_path.id)
add_course('Desarrollo móvil', 'ANDROID nivel INTERMEDIO Kotlin', 'AristiDevs', 'https://www.youtube.com/watch?v=UaR7GSNACsM', default_path.id)
add_course('Desarrollo móvil', 'ANDROID desde CERO Kotlin P1', 'AristiDevs', 'https://www.youtube.com/watch?v=vJapzH_46a8', default_path.id)
add_course('Desarrollo móvil', 'ANDROID desde CERO Kotlin P2', 'AristiDevs', 'https://www.youtube.com/watch?v=ndqIqh6joGA', default_path.id)
add_course('Desarrollo móvil', 'DART | Para Apps mobiles', 'Informatica Live', 'https://www.youtube.com/watch?v=fqOmQ_wIEMo', default_path.id)
add_course('Desarrollo móvil', 'React Native EXPO 2025', 'Codigo 369', 'https://www.youtube.com/watch?v=GaXEzkDs6Yk', default_path.id)
add_course('Desarrollo móvil', 'Aprende FLUTTER! (3 proyectos)', 'Codigo 369', 'https://www.youtube.com/watch?v=IRLLVmN7nQI', default_path.id)
add_course('Desarrollo móvil', 'Apps Para Ganar Dinero | Flutter', 'Adrián Sáenz', 'https://www.youtube.com/watch?v=YtqmGxskJ9k', default_path.id)
add_course('Desarrollo móvil', 'App para Android con IA', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=bjIincNu8DU', default_path.id)

# --- BASES DE DATOS ---
add_course('Bases de Datos', 'SQL desde CERO', 'Soy Dalto', 'https://www.youtube.com/watch?v=DFg1V-rO6Pg', default_path.id)
add_course('Bases de Datos', 'SQL Master (MySQL/Postgres)', 'Sergie Code', 'https://www.youtube.com/watch?v=Fca_kWJJXvo', default_path.id)
add_course('Bases de Datos', 'MongoDB desde CERO', 'Informatica Live', 'https://www.youtube.com/watch?v=rcZlFmioTkE', default_path.id)
add_course('Bases de Datos', 'SQL + MYSQL COMPLETO', 'Informatica Live', 'https://www.youtube.com/watch?v=zZeNd2qAAeU', default_path.id)
add_course('Bases de Datos', 'Curso de Oracle', 'Edutin', 'https://www.youtube.com/watch?v=922f5D9UrQ0', default_path.id)
add_course('Bases de Datos', 'SQL y BASES DE DATOS Cero', 'MoureDev', 'https://www.youtube.com/watch?v=OuJerKzV5T0', default_path.id)

# --- FUNDAMENTOS ---
add_course('Fundamentos', 'GIT desde CERO', 'Soy Dalto', 'https://www.youtube.com/watch?v=9ZJ-K-zk_Go', default_path.id)
add_course('Fundamentos', 'Lógica de Programación', 'Sergie Code', 'https://www.youtube.com/watch?v=tIS-1PmHAkE', default_path.id)
add_course('Fundamentos', 'GIT Y GITHUB desde cero', 'Sergie Code', 'https://www.youtube.com/watch?v=7ylE8cm3mb0', default_path.id)
add_course('Fundamentos', 'La terminal de Linux', 'Informatica Live', 'https://www.youtube.com/watch?v=XspFc1RFJtE', default_path.id)
add_course('Fundamentos', 'BASH CON LINUX', 'Informatica Live', 'https://www.youtube.com/watch?v=qRodaUVPv4s', default_path.id)
add_course('Fundamentos', 'Lógica de Programación [Parte 1]', 'MoureDev', 'https://www.youtube.com/watch?v=TdITcVD64zI', default_path.id)
add_course('Fundamentos', 'Lógica de Programación [Parte 2]', 'MoureDev', 'https://www.youtube.com/watch?v=b-kk1WQo-YA', default_path.id)
add_course('Fundamentos', 'Domina la Lógica (20 Ejercicios)', 'MoureDev', 'https://www.youtube.com/watch?v=qSup_483xO8', default_path.id)
add_course('Fundamentos', 'Principios SOLID Desde Cero', 'MoureDev', 'https://www.youtube.com/watch?v=ASBC5drF-QU', default_path.id)
add_course('Fundamentos', 'GIT y GITHUB Principiantes', 'MoureDev', 'https://www.youtube.com/watch?v=3GymExBkKjE', default_path.id)

# --- HERRAMIENTAS ---
add_course('Herramientas', 'VISUAL STUDIO CODE', 'Soy Dalto', 'https://www.youtube.com/watch?v=TbzrOz8HbFM', default_path.id)
add_course('Herramientas', 'Curso de Canva', 'Edutin', 'https://www.youtube.com/watch?v=fhckFGjdJsw', default_path.id)
add_course('Herramientas', 'WINDOWS 11', 'Informatica Live', 'https://www.youtube.com/watch?v=4X61mpGRcG4', default_path.id)
add_course('Herramientas', 'NEOVIM - NVIM', 'Informatica Live', 'https://www.youtube.com/watch?v=gZUWWhE4ADU', default_path.id)
add_course('Herramientas', 'Domina APIs con Postman', 'Informatica Live', 'https://www.youtube.com/watch?v=L_4LltTgCV8', default_path.id)
add_course('Herramientas', 'Photoshop Para Principiantes', 'Adrián Sáenz', 'https://www.youtube.com/watch?v=e1fGSA9obAw', default_path.id)
add_course('Herramientas', 'ADOBE PREMIERE PRO 2026', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=5DGY2HkTZoE', default_path.id)
add_course('Herramientas', 'ADOBE AFTER EFFECTS 2026', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=9MZMwzNkUEM', default_path.id)
add_course('Herramientas', 'PHOTOSHOP 2026', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=sboPfePGFsI', default_path.id)
add_course('Herramientas', 'Figma para Developers', 'Mokkapp', 'https://www.youtube.com/watch?v=b07ELp3mWKI', default_path.id)
add_course('Herramientas', 'Taller Figma para Programadores', 'Ingennus', 'https://www.youtube.com/watch?v=p53yCQoS6qg', default_path.id)

# --- DEVOPS ---
add_course('Devops', 'DOCKER COMPLETO', 'Informatica Live', 'https://www.youtube.com/watch?v=6wbfODetPbE', default_path.id)
add_course('Devops', 'DEVOPS # 1', 'Informatica Live', 'https://www.youtube.com/watch?v=EUPvLLsheVI', default_path.id)
add_course('Devops', 'DEVOPS # 2', 'Informatica Live', 'https://www.youtube.com/watch?v=J3lLkRCr9ok', default_path.id)
add_course('Devops', 'DEVOPS # 3', 'Informatica Live', 'https://www.youtube.com/watch?v=ode82i8syG0', default_path.id)
add_course('Devops', 'LINUX - DEBIAN', 'Informatica Live', 'https://www.youtube.com/watch?v=8c6LLNk7oLE', default_path.id)
add_course('Devops', 'Linux & Ubuntu', 'Informatica Live', 'https://www.youtube.com/watch?v=VNObd3iSm4Q', default_path.id)
add_course('Devops', 'BASH y la Terminal', 'MoureDev', 'https://www.youtube.com/watch?v=ABgLEKFhlZE', default_path.id)
add_course('Devops', 'KALI LINUX 2025 | HACKING', 'RINKU', 'https://www.youtube.com/watch?v=P7jvr_dnD8U', default_path.id)
add_course('Devops', 'FORENSE DIGITAL desde CERO', 'Hackavis', 'https://www.youtube.com/watch?v=d05PTuy2XGk', default_path.id)

# --- CIENCIA DATOS ---
add_course('Ciencia datos', 'PYTHON desde CERO', 'Soy Dalto', 'https://www.youtube.com/watch?v=nKPbfIU442g', default_path.id)
add_course('Ciencia datos', 'POO con PYTHON', 'Soy Dalto', 'https://www.youtube.com/watch?v=HtKqSJX7VoM', default_path.id)
add_course('Ciencia datos', 'Python Avanzado: POO', 'Sergie Code', 'https://www.youtube.com/watch?v=NlKzy-yRAuI', default_path.id)
add_course('Ciencia datos', 'Python desde cero + Pandas', 'Sergie Code', 'https://www.youtube.com/watch?v=_uPVSW0cF6c', default_path.id)
add_course('Ciencia datos', 'RUST Programación Moderna', 'Informatica Live', 'https://www.youtube.com/watch?v=DC4xFMLsuxs', default_path.id)
add_course('Ciencia datos', 'CURSO DE GO', 'Informatica Live', 'https://www.youtube.com/watch?v=c4Y1pQ1necw', default_path.id)
add_course('Ciencia datos', 'JAVA - 7 Horas', 'Informatica Live', 'https://www.youtube.com/watch?v=jpUNTZKCexY', default_path.id)
add_course('Ciencia datos', 'C# - 6 Horas', 'Informatica Live', 'https://www.youtube.com/watch?v=vxYkwdtu16E', default_path.id)
add_course('Ciencia datos', 'PYTHON - 11 HORAS', 'Informatica Live', 'https://www.youtube.com/watch?v=jRwW7WCCkIo', default_path.id)
add_course('Ciencia datos', 'Python desde Cero Principiantes', 'MoureDev', 'https://www.youtube.com/watch?v=Kp4Mvapo5kc', default_path.id)
add_course('Ciencia datos', 'Python desde Cero Intermedio', 'MoureDev', 'https://www.youtube.com/watch?v=TbcEqkabAWU', default_path.id)
add_course('Ciencia datos', 'Aprende Go (Golang)', 'freeCodeCamp', 'https://www.youtube.com/watch?v=L_yYVEC8GZo', default_path.id)
add_course('Ciencia datos', 'Web Scraping con Python', 'freeCodeCamp', 'https://www.youtube.com/watch?v=yKi9-BfbfzQ', default_path.id)

# --- INTELIGENCIA ARTIFICIAL ---
add_course('Inteligencia Artificial', 'INTELIGENCIA ARTIFICIAL Completo', 'Informatica Live', 'https://www.youtube.com/watch?v=vnvrE_38od0', default_path.id)
add_course('Inteligencia Artificial', 'N8N desde CERO 2026', 'Sinergia', 'https://www.youtube.com/watch?v=6CdgFR0VsVI', default_path.id)
add_course('Inteligencia Artificial', 'DESARROLLO con IA', 'MoureDev', 'https://www.youtube.com/watch?v=3spCFnMSGIY', default_path.id)
add_course('Inteligencia Artificial', 'App real con 3 IAs', 'MoureDev', 'https://www.youtube.com/watch?v=7wXJPIiSolo', default_path.id)
add_course('Inteligencia Artificial', 'Curso IA Gratis', 'Adrián Sáenz', 'https://www.youtube.com/watch?v=Phal-sPAunk', default_path.id)
add_course('Inteligencia Artificial', 'N8N: Agentes IA', 'Adrián Sáenz', 'https://www.youtube.com/watch?v=3IvcIPDGB1k', default_path.id)
add_course('Inteligencia Artificial', 'Desarrollo Aplicaciones con IA', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=faJjZ58ptI8', default_path.id)

# --- TESTING (QA) ---
add_course('Testing (QA)', 'Cypress en Español', 'Informatica Live', 'https://www.youtube.com/watch?v=R70lI9aDKPg', default_path.id)
add_course('Testing (QA)', 'QA ENGINEER AUTOMATION II', 'Informatica Live', 'https://www.youtube.com/watch?v=LGlkyLLjcac', default_path.id)
add_course('Testing (QA)', 'QA ENGINEER ROAD MAP', 'Informatica Live', 'https://www.youtube.com/watch?v=_6Q8rcurErY', default_path.id)
add_course('Testing (QA)', 'PLAYWRIGHT | AUTOMATIZA', 'Informatica Live', 'https://www.youtube.com/watch?v=ovEhcf7c8Y4', default_path.id)
add_course('Testing (QA)', 'CURSO DE SELENIUM', 'Informatica Live', 'https://www.youtube.com/watch?v=HtYtCrg8rO8', default_path.id)
add_course('Testing (QA)', 'ROBOT Framework', 'Informatica Live', 'https://www.youtube.com/watch?v=wdmr0BfBbhM', default_path.id)
add_course('Testing (QA)', 'Testing QA ENGINEER - 7 HORAS', 'Informatica Live', 'https://www.youtube.com/watch?v=LJsLb0ZaVSg', default_path.id)

# --- CLOUD ---
add_course('Cloud', 'HOSTING desde CERO', 'Soy Dalto', 'https://www.youtube.com/watch?v=hikoV1Q9EzY', default_path.id)
add_course('Cloud', 'Adsense y Afiliados', 'soesve', 'https://www.youtube.com/watch?v=NOkMJti3d98', default_path.id)
add_course('Cloud', 'Monetización en Internet', 'soesve', 'https://www.youtube.com/watch?v=v2O21JJvLIU', default_path.id)
add_course('Cloud', 'Google Ads (Completo)', 'soesve', 'https://www.youtube.com/watch?v=pHpypubPELM', default_path.id)

# --- ENGLISH ---
add_course('English', 'Curso Inglés Rápido y Fácil', 'Adrián Sáenz', 'https://www.youtube.com/watch?v=w-ixdGvrixI', default_path.id)

# --- CATEGORIA EXTRA ---
add_course('Herramientas', 'AFFINITY', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=fW4Xwh6POec', default_path.id)
add_course('Herramientas', 'VEGAS PRO 23', 'Yoney Gallardo', 'https://www.youtube.com/watch?v=FhpoizYeZps', default_path.id)
add_course('Fundamentos', 'Diseño de Videojuegos', 'Ingennus', 'https://www.youtube.com/watch?v=dOpvnqcsN4k', default_path.id)

puts "¡Proceso finalizado! Se han cargado #{Course.count} cursos y sus lecciones."