import axios from 'axios';

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const instance = axios.create({
  baseURL: '/api/v1/',
  headers: {
    'X-CSRF-Token': csrfToken
  }
});

export default instance;
