function init() {
    //read all users and set logged in user
    const response = Actions.callApi({ url: '/api/users', method: 'get' });
    if (Array.isArray(response) && response.length) setLoggedInUser(response[0]);

    //read settings and set app state
    const sresp = Actions.callApi({ url: '/api/settings', method: 'get' });
    if (Array.isArray(sresp) && sresp.length && sresp[0].avatar_border_radius) {
      appState.update({ settings: { avatar_border_radius: sresp[0].avatar_border_radius } });    
    }
}
