# sana_health_t

Esta es la prueba técnica proporcionada por Sana Health Technologies.

La prueba técnica consiste en implementar un marketplace de productos utilizando la API pública DummyJSON.

## Cómo usarlo
1. Primero, [descarga el APK](https://drive.google.com).  
2. Luego, instálalo.  
3. Rechaza las advertencias de Google Play.  
4. Abre la aplicación.  

## Requerimientos Funcionales
* Listado de productos  
* Búsqueda por texto  
* Filtro por categorías  
* Vista detallada del producto  
* Gestión de estado  
* CRUD totalmente funcional  

> ⚠️ Nota: Los productos que son agregados por el usuario se almacenan solo temporalmente en el BLoC. Dado que DummyJSON no permite agregar, eliminar o editar productos, todas estas funcionalidades son volátiles. Si la aplicación se cierra, todo vuelve al estado inicial.  

## Requerimientos Técnicos
* Versión estable de Flutter  
* Gestión de estado  
* Buena estructura de proyecto  
* Mejores prácticas  

## Endpoints Utilizados
* `/products`  
* `/search?q=$query`  
* `/$id`  
* `/add`  
* `/categories`  
* `/category/$category`  

## Decisiones Técnicas
Para este proyecto, prioricé la funcionalidad sobre la interfaz de usuario (UI), ya que el tiempo de entrega era corto. Decidí implementar BLoC como gestor de estado porque es fácil de leer y entender. Solo implementé 2 BLoCs: el de productos y otro para manejar las categorías.

También creé 2 providers: uno para el formulario de productos y otro para las categorías. Todo está organizado en carpetas. Las pantallas principales no superan las 200 líneas.

## Vista Previa
1. Obtención y listado de productos desde la API dummyjson
<p align="center">
  <img src="images/20260224-133411.jpg" alt="2026-02-24 13:34" width="300">
</p>
 
3. Búsqueda de productos por palabra clave
<p align="center">
  <img src="images/20260224-133422.jpg" alt="2026-02-24 13:34" width="300">
</p>
5. Estas son todas las categorías que ofrece la API dummyjson
<p align="center">
  <img src="images/20260224-133432.jpg" alt="2026-02-24 13:34" width="300">
  <img src="images/20260224-133437.jpg" alt="2026-02-24 13:34" width="300">
</p>
6. Pantalla de detalle del producto
<p align="center">
  <img src="images/20260224-133442.jpg" alt="2026-02-24 13:34" width="300">
  <img src="images/20260224-133450.jpg" alt="2026-02-24 13:34" width="300">
  <img src="images/20260224-133500.jpg" alt="2026-02-24 13:35" width="300">
</p>
7. Notificación antes de eliminar un producto
<p align="center">
  <img src="images/20260224-133506.jpg" alt="2026-02-24 13:35" width="300">
</p>
8. Editar la información de un producto
<p align="center">
  <img src="images/20260224-133516.jpg" alt="2026-02-24 13:35" width="300">
  <img src="images/20260224-133520.jpg" alt="2026-02-24 13:35" width="300">
  <img src="images/20260224-133524.jpg" alt="2026-02-24 13:35" width="300">
</p>
9. Formulario para agregar un nuevo producto
<p align="center">
  <img src="images/20260224-133537.jpg" alt="2026-02-24 13:35" width="300">
  <img src="images/20260224-133542.jpg" alt="2026-02-24 13:35" width="300">
  <img src="images/20260224-133545.jpg" alt="2026-02-24 13:35" width="300">
</p>
