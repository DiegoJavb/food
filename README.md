# Eat Healthy

El siguiente proyecto muestra el desarrollo de una Aplicación Móvil, que permite a los usuarios llevar un registro sobre los alimentos que ingieren en base a un análisis elaborado por un Nutricionista.

**Video demostrativo**

**Realizado por:**

- Diego Bacuy

## 1. Herramientas de Desarrollo
### FLUTTER

La aplicación móvil será nativa híbrida por lo que Flutter es un buen framework para este tipo de aplicaciones. Al ser modular, permite separar la lógica del negocio de las interfaces de usuario.

### FIREBASE

Firebase es una plataforma cuya función es desarrollar y facilitar la creación de apps de elevada calidad de una forma rápida, ya que provee una gran cantidad de micro-servicios que permiten el desarrollo de la aplicación en su totalidad. Entre las herramientas, que ofrece firebase se utilizo el almacenamiento de datos firestore, storage para las imagenes y hosting para su despliegue.

### 1.1 BurnDown chart

A continuacion se muestra como ha ido creciendo el proyecto desde su inicio

![image](https://user-images.githubusercontent.com/42130200/127097020-f8b794ed-8f27-4f16-ac0f-d5cf6e0c83d9.png)
![image](https://user-images.githubusercontent.com/42130200/127097026-4ebb99ce-cdda-4cf3-a9d6-6e74ca3eeb9a.png)

## 2. Estructura y arquitectura
### - Arquitectura
La arquitectura de la aplicación movil se muestra en la siguiente imagen
![image](https://user-images.githubusercontent.com/42130200/127058102-7a10a3ef-a83e-4e89-ab96-dbe9dc32c24a.png)

### - Estructura
La estructura de la base de datos, se muestra en la siguiente imagen.
![image](https://user-images.githubusercontent.com/42130200/131374137-56c6a25d-a291-4325-a84f-43e3348a6eff.png)

## 3. Funcionalidades principales
En el desarrollo de la Aplicación Móvil, se pudo recolectar los requerimientos y funcionalidades. A continuación se muestran algunos de los más importantes.

### - iniciar sesión
El usuario puede iniciar sesion o registrarse en la aplicacón de dos formas, usando su usuario y contraseña o con credenciales de Google.

![image](https://user-images.githubusercontent.com/42130200/131371655-2b10e919-8d9c-401f-97c5-975a177b64a1.png)

### - Pagina inicial
El usuario podra ver las opciones navegación hacia los diferentes módulos que presenta la aplicación.

![image](https://user-images.githubusercontent.com/42130200/131373776-e7d1b702-ca89-4966-9cfc-2a4a4f107779.png)
![image](https://user-images.githubusercontent.com/42130200/131373035-ee6a2ad7-58fb-4846-9251-ca83c236fa6a.png)

### - Editar informacion
Para usar la aplicación en su totalidad el usuario debe actualizar su información personal y así ser identificado entre los usuarios.

![image](https://user-images.githubusercontent.com/42130200/131371711-20b7911b-71c5-48fa-b27f-a36b0b8b0fff.png)

### - Registrar cita realizada
Si el usuario se relaciona con un personal de salud que no posee la aplicacion, se puede registrar la cita llenando los campos correspondientes.

![image](https://user-images.githubusercontent.com/42130200/131372299-fd48ffbe-8175-4ddc-bc21-b7049d1c0f36.png)

### - Recomendaciones
La aplicación permite a los usuarios llenar una lista con los alimentos que debería consumir en mayor o menor medida.

![image](https://user-images.githubusercontent.com/42130200/131372658-a82706b5-8ac1-4ffa-ba6f-1727c2d39a56.png)

### - Registro para ser enviado
Si el usuario a actualizado su información, podra acceder a una lista de usuarios y añadir a alguno como su contacto para enviarle su registro alimenticio, el cual continen los campos de desayuno, almuerzo, cena y aperitivos que seran llenados de manera general en un tiempo determinado.

![image](https://user-images.githubusercontent.com/42130200/131372723-35e925a1-33bb-4dd3-96b8-05f3d771e303.png)

### - Evaluación recibida
Cuado el nutricionista responda, el usuario paciente podrá observar el registro enviado y la evaluación recibida.

![image](https://user-images.githubusercontent.com/42130200/131372889-8b5df763-4c92-4bfa-a6cd-4817a1d8d796.png)

### - Sitio de noticias
La aplicación presenta una sección de noticias sobre alimentación y salud.

![image](https://user-images.githubusercontent.com/42130200/131372923-d70acb13-29ad-4849-932a-95ae804377f4.png)

## 4. Instalación
## 1. Clonar el repositorio
```bash
  git clone https://github.com/DiegoJavb/food.git
  cd my-project
```
## 2. Instalar las dependencias
```bash
  flutter pub get 
```
## 3. Seleccionar dispositivo físico o virtual
![image](https://user-images.githubusercontent.com/42130200/131381144-419c1223-080b-4010-9780-b99182d14de3.png)

Posteriormente depuraremos la aplicación
## 5. Anexos
En el siguiente link, se encuentra toda la documentación como Manual Técnico, Manual de Instalación, Informe Técnico y los diferentes anexos del proyecto. [Documentación](https://github.com/DiegoJavb/Documentacion_Tesis.git)


For help getting started with Flutter, view our

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)


[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
