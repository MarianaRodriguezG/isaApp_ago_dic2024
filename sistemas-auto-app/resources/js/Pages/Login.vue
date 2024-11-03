<template>
    <div>
      <h2>Iniciar Sesión</h2>
      <form @submit.prevent="submitForm">
        <div>
          <label for="nroControl">Nro. Control</label>
          <input
            type="text"
            id="nroControl"
            v-model="nroControl"
            @blur="validateNroControl"
            placeholder="Nro. Control"
          />
          <span v-if="errors.nroControl">{{ errors.nroControl }}</span>
        </div>
        <div>
          <label for="password">Contraseña</label>
          <input
            :type="showPassword ? 'text' : 'password'"
            id="password"
            v-model="password"
            @blur="validatePassword"
          />
          <button type="button" @click="togglePasswordVisibility">
            {{ showPassword ? 'Ocultar' : 'Mostrar' }}
          </button>
          <span v-if="errors.password">{{ errors.password }}</span>
        </div>
        <button type="submit">Aceptar</button>
        <p><a href="/register">¿No tienes una cuenta? Regístrate</a></p>
      </form>
    </div>
  </template>

  <script>
  export default {
    data() {
      return {
        nroControl: '',
        password: '',
        showPassword: false,
        errors: {}
      };
    },
    methods: {
      validateNroControl() {
        const regex = /^T\d{2}120\d{3}$/;
        if (!this.nroControl.match(regex)) {
          this.errors.nroControl = 'El Nro. Control debe tener el formato TXX120XXX.';
        } else {
          delete this.errors.nroControl;
        }
      },
      validatePassword() {
        const regex = /^(?!\s)[A-Za-z\d@$!%*?&]{8,}$/;
        if (!this.password.match(regex)) {
          this.errors.password = 'La contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales, y no empezar con espacios.';
        } else {
          delete this.errors.password;
        }
      },
      togglePasswordVisibility() {
        this.showPassword = !this.showPassword;
      },
      submitForm() {
        this.validateNroControl();
        this.validatePassword();

        if (Object.keys(this.errors).length === 0) {
          // Enviar los datos al backend
          this.$inertia.post('/login', {
            nroControl: this.nroControl,
            password: this.password
          });
        } else {
          alert('Por favor, corrija los errores antes de enviar el formulario.');
        }
      }
    }
  };
  </script>

  <style scoped>
  form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }
  span {
    color: red;
    font-size: 0.9rem;
  }
  button {
    align-self: flex-start;
  }
  </style>
