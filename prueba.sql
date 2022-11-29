

--Creamos la base de datos
CREATE DATABASE prueba_nicolas_saavedra_404;

--Ingresamos a la base de datos
\c prueba_nicolas_saavedra_404;

--REQUERIMIENTOS

-- 1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos.

CREATE TABLE movies(
id SERIAL PRIMARY KEY,
nombre  VARCHAR(255),
anno INT);


CREATE TABLE tags(
id SERIAL PRIMARY KEY,
tag VARCHAR(32));


-- 2. Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados.

INSERT INTO movies (nombre, anno)
values
('Star Wars episode IV  A new Hope', 1977),
('La Princesa Mononoke', 1997),
('TLOR The Fellowship of the Ring', 2001),
('House of 1000 Corpses', 2003),
('La Granja', 2006);


INSERT INTO tags (tag)
values
('Ciencia Ficcion'),
('Aventura'),
('Fantasia'),
('Guerra'),
('Animacion');

CREATE TABLE movie_tags (
id SERIAL PRIMARY KEY,
movie_id INT,
tag_id INT,
FOREIGN KEY (movie_id) REFERENCES movies(id),
FOREIGN KEY (tag_id) REFERENCES tags(id));


INSERT INTO movie_tags (movie_id, tag_id)
values
(1,1),(1,2),(1,3),(2,1),(2,2);


-- 3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.

SELECT movies.nombre, COUNT(movie_tags.tag_id) FROM movies LEFT JOIN movie_tags ON movies.id = movie_tags.movie_id GROUP BY movies.nombre ORDER BY COUNT(movie_tags.tag_id)DESC;


-- 4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.


CREATE TABLE preguntas (
id SERIAL PRIMARY KEY,
pregunta VARCHAR(255),
respuesta_correcta VARCHAR);

CREATE TABLE usuarios (
id SERIAL PRIMARY KEY,
nombre VARCHAR(255),
edad INT);

CREATE TABLE respuestas(
id SERIAL PRIMARY KEY,
respuesta VARCHAR(255),
usuario_id INT,
pregunta_id INT,
FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
FOREIGN KEY (pregunta_id) REFERENCES preguntas(id));



-- 5. Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada dos veces correctamente por distintos usuarios, 
-- la pregunta 2 debe estar contestada correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas.
    --A) Contestada correctamente significa que la respuesta indicada en la tabla respuestas es exactamente igual al texto indicado en la tabla de preguntas.


INSERT INTO usuarios (nombre, edad)
values
('Nicolas', 34),
('Lissette', 28),
('Valentin', 20),
('Lorena', 50),
('Cristian', 36);



INSERT INTO preguntas (pregunta, respuesta_correcta)
values
('¿De que pais es la serie Ultraman?' , 'Japon'),
('¿En que planeta viene el personaje ficticio ALF?', 'Melmac'),
('¿En que planeta nacio Anakin Skywalker' , 'Tatooine'),
('¿Contra quien pelea Godzilla en la pelicula del 2021?', 'King Kong'),
('¿Cual es la identidad de Iron Man', 'Tony Stark');

INSERT INTO respuestas (respuesta, pregunta_id, usuario_id)
values
('Japon',1,1),
('Japon',1,2),
('Melmac',2,3),
('El Perro Chocolo',3,4),
('Felipe Camiroaga',4,5);

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta).

SELECT usuarios.nombre, COUNT (preguntas.respuesta_correcta) respuestas_correctas  FROM preguntas RIGHT JOIN respuestas ON respuestas.respuesta = preguntas.respuesta_correcta JOIN usuarios ON usuarios.id = respuestas.usuario_id GROUP BY usuario_id, usuarios.nombre ORDER BY respuestas_correctas  DESC;

-- 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta.

SELECT preguntas.pregunta, COUNT(respuestas.respuesta) usuarios_con_respuesta_correcta FROM respuestas RIGHT JOIN preguntas ON preguntas.respuesta_correcta = respuestas.respuesta GROUP BY preguntas.id ORDER BY preguntas.id ;

-- 8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación.

ALTER TABLE respuestas DROP CONSTRAINT respuestas_usuario_id_fkey; 
ALTER TABLE respuestas ADD CONSTRAINT respuestas_usuario_id_fkey FOREIGN KEY(usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;
DELETE FROM usuarios WHERE id = 1;


-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.
ALTER TABLE usuarios ADD CHECK (edad >18);

--10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único.
ALTER TABLE usuarios ADD email VARCHAR UNIQUE;




