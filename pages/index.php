<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Bolsa Laboral en Misiones</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
  <header>
    <!-- ... -->
  </header>
  
  <main>
    <div class="container">
      <h2>Vacantes Disponibles</h2>
      <?php
      // Configuración de la conexión a la base de datos
      $host = 'localhost'; // Cambia esto por tu host de PostgreSQL
      $dbname = 'bolsa_empleo_misiones'; // Cambia esto por el nombre de tu base de datos
      $username = 'postgres'; // Cambia esto por tu nombre de usuario de PostgreSQL
      $password = 'postgres'; // Cambia esto por tu contraseña de PostgreSQL
      
      try {
          $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $username, $password);
          $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

          // Consulta preparada para obtener las vacantes activas
          $query = "SELECT * FROM ofertas_laborales WHERE activa = :activa";
          $statement = $pdo->prepare($query);
          $statement->bindValue(':activa', true, PDO::PARAM_BOOL);
          $statement->execute();

          // Mostrar los resultados
          echo '<div class="vacancies">';
          while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
              echo '<div class="vacancy">';
              echo '<h3>' . htmlspecialchars($row['nombre_puesto']) . '</h3>';
              echo '<p>' . htmlspecialchars($row['descripcion']) . '</p>';
              echo '<button>Postularse</button>';
              echo '</div>';
          }
          echo '</div>';
      } catch (PDOException $e) {
          die("Error: " . $e->getMessage());
      }
      ?>
    </div>
  </main>

  <footer>
    <!-- ... -->
  </footer>
</body>
</html>
