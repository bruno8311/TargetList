# TargetList - Lista de Tarjetas Flutter

Una aplicación móvil desarrollada en Flutter que permite gestionar una lista de tarjetas con funcionalidades CRUD (Crear, Leer, Actualizar, Eliminar).

## 📱 Características

- **Lista de tarjetas**: Visualización de tarjetas con título, descripción resumida y una imagen.
- **Vista detallada**: Acceso a una pantalla de detalle donde se muestra información adicional en cada tarjeta.
- **Creación de tarjetas**: Creación de las tarjetas con campos obligatorios (titulo, descripción y detalle) y campos opcionales (URL imagen).
- **Editar tarjetas**: Modificación de tarjetas existentes con todos sus campos (titulo, descripcion, detalle y URL de imagen).
- **Eliminar tarjetas**: Eliminación de tarjetas de la lista.
- **Navegación intuitiva**: Interfaz fluida entre pantallas.

## Arquitectura de la Aplicación

### Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── models/
│   └── tarjeta_item.dart       # Modelo de datos para las tarjetas
└── presentation/
    └── screens/
        ├── home_screen.dart     # Pantalla principal con lista
        ├── details_screen.dart  # Pantalla de detalles
        └── form_screen.dart     # Pantalla de formulario
```

### Componentes Principales

#### 1. **HomeScreen** (Pantalla Principal)
- **Tipo**: `StatefulWidget`
- **Función**: Muestra la lista de tarjetas en formato Card
- **Características**:
  - Lista inicial generada con `ListView.builder` para optimización de rendimiento.
  - Cada tarjeta muestra título y descripción. (En caso de de que descripcion exceda los 100 caracteres, la descripcion se trunca, para verla completa se debe ingresar a la pantalla de detalle).
  - CircleAvatar con imagen.
  - FloatingActionButton para agregar nuevas tarjetas
  - Navegación a pantallas de detalles y formularios

#### 2. **DetailsScreen** (Pantalla de Detalles)
- **Tipo**: `StatelessWidget`
- **Función**: Muestra información completa de una tarjeta específica
- **Características**:
  - Imagen ampliada (150x150px) con bordes redondeados y sombra
  - Visualización completa del título, descripción y detalle
  - Secciones organizadas con etiquetas en negritas
  - Área de detalle con scroll limitado para mejor UX
  - Botones para editar y eliminar la tarjeta
  - Retorna resultados a la pantalla principal mediante Navigator

#### 3. **FormScreen** (Pantalla de Formulario)
- **Tipo**: `StatefulWidget`
- **Función**: Formulario para crear o editar tarjetas
- **Características**:
  - Campo de título (obligatorio)
  - Campo de descripción breve.
  - Campo de detalle completo.
  - Campo de URL de imagen (opcional) con teclado URL.
  - Campos de texto controlados con `TextEditingController`.
  - Validación de campos obligatorios.
  - Reutilizable para crear y editar (recibe parámetros opcionales).

#### 4. **TarjetaItem** (Modelo de Datos)
- **Tipo**: Clase
- **Propiedades**: 
  - `titulo` (String, obligatorio)
  - `descripcion` (String, obligatorio) - Resumen para la lista
  - `detalle` (String, obligatorio) - Información completa para detalles
  - `imageUrl` (String?, opcional) - URL de imagen

## 🔧 Consideraciones Técnicas Importantes

### Gestión del Estado
- **setState()**: Utilizado para actualizar la UI cuando cambia la lista de tarjetas
- **StatefulWidget vs StatelessWidget**: 
  - StatefulWidget para componentes que manejan estado (HomeScreen, FormScreen)
  - StatelessWidget para componentes de solo lectura (DetailsScreen)

### Navegación
- **Navigator.push()**: Para navegar a nuevas pantallas
- **Navigator.pop()**: Para regresar con datos de resultado
- **Async/Await**: Manejo de navegación asíncrona para recibir datos de retorno

### Optimización de Performance
- **ListView.builder()**: Construcción lazy de elementos para listas grandes
- **TextOverflow.ellipsis**: Truncado eficiente de texto largo
- **const constructors**: Widgets inmutables para mejor rendimiento

### Gestión de Memoria
- **TextEditingController.dispose()**: Liberación de recursos en FormScreen
- **late final**: Inicialización tardía pero inmutable de controladores

## 🛠️ Tecnologías y patrones implementados

- **Gestores de estado:** Provider
- **Arquitectura limpia:** Separación en capas (domain, data, presentation)
- **Persistencia de datos:** SharedPreferences

## 🚀 Instalación y Ejecución

### Prerrequisitos
- Flutter SDK (versión 3.8.1 o superior)
- Dart SDK
- Editor de código VS Code.

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/bruno8311/TargetList.git
   cd TargetList
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📋 Funcionalidades Detalladas

### Operaciones CRUD

1. **Create (Crear)**
   - Botón flotante '+' en pantalla principal
   - Formulario con validación de título, descripción y detalle
   - Campo opcional para URL de imagen
   - Adición a la lista con `setState()`

2. **Read (Leer)**
   - Lista en pantalla principal con imagen, título y descripción breve
   - Vista detallada al tocar una tarjeta con imagen ampliada, título, descripción y detalle completo

3. **Update (Actualizar)**
   - Botón "Editar" en pantalla de detalles
   - Formulario pre-rellenado con todos los campos existentes
   - Actualización por índice en la lista

4. **Delete (Eliminar)**
   - Botón "Eliminar" en pantalla de detalles
   - Confirmación visual con botón rojo
   - Remoción por índice con `removeAt()`

## 🔮 Posibles Mejoras Futuras

- Persistencia de datos (SQLite, SharedPreferences)
- Búsqueda y filtrado de tarjetas
- Categorización de tarjetas con iconos
- Sincronización en la nube
- Animaciones de transición
- Tema oscuro/claro
- Internacionalización (i18n)
- Carga de imágenes desde galería local
- Compresión automática de imágenes
- Modo offline con cache de imágenes
