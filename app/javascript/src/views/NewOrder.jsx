import React, { useReducer, useEffect } from 'react';
import ReactDOM from 'react-dom';
import normalize from 'json-api-normalizer';
import build from 'redux-object';
import axios from '../utils/axios';

import Form from './newOrder/Form';

const initialState = {
  users: [],
  fetchingUsers: true,
  selectedUser: {},
};

const reducer = (state, action) => {
  switch (action.type) {
    case 'GET_USERS_SUCCESS': {
      const {
        users,
      } = action;
      return {
        ...state,
        users,
        fetchingUsers: false
      };
    }
    case 'GET_USERS_FAILURE': {
      return {
        ...state,
        users: {},
        fetchingUsers: false
      };
    }
    case 'SELECT_USER': {
      const {
        selectedUser,
      } = action;
      return {
        ...state,
        selectedUser,
      };
    }
    default:
      return state;
  }
};

const NewOrder = () => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const loadUsers = (inputValue) => {
    return axios
      .get(`users?query=${inputValue}`)
      .then(({ data }) => {
        if (data.data.length) {
          const usersData = normalize(data, { endpoint: '/users' });
          const usersBuild = build(usersData, 'user', null);

          dispatch({ type: 'GET_USERS_SUCCESS', users: usersData });

          const users = usersBuild.map(user => ({ value: user.id, label: ` ${user.name} - ${user.email}` }))
          return users;
        }
      })
      .catch(err => {
        console.log(err)
        dispatch({ type: 'GET_USERS_FAILURE' });
      });
  };

  const userOptions = inputValue =>
    new Promise(resolve => {
      setTimeout(() => {
        resolve(loadUsers(inputValue));
      }, 500);
    });

  const selectUser = userId => {
    if (userId) {
      const users = build(state.users, 'user', null);
      const selectedUser = users.find(x => x.id === userId)
      dispatch({ type: 'SELECT_USER', selectedUser });
    } else {
      const selectedUser = {}
      dispatch({ type: 'SELECT_USER', selectedUser });
    }
  }


  const createDraft = (values, setSubmitting, setFieldError) => {
    const params = {
      name: values.name,
      email: values.email,
      contact_number: values.contactNumber,
      address: values.address,
      ...(values.userId && { user_id: values.userId })
    }
    axios
      .post('orders/drafts', params)
      .then(({ data }) => {
        window.location.href = `/admin/orders/drafts/${data.id}`
      })
      .catch(({ response }) => {
        setSubmitting(false);
        // setFieldError('amount', response.data.errors[0]);
      });
  }

  const { selectedUser } = state;

  return (
    <div className="container mb-5">
      <div className="row">
        <div className="col-md-6 mx-auto">
          <div className="title title-md">Draft New Order</div>
          <p className="mb-4 text-muted">After drafting your order, you'll be able to assign order items to it.</p>
          <Form
            createDraft={createDraft}
            userOptions={userOptions}
            selectedUser={selectedUser}
            selectUser={selectUser}
          />
        </div>
      </div>
    </div>
  )
}

ReactDOM.render(<NewOrder />, document.getElementById('new-order'));
