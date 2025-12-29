    function handleSaveSettings() {
      Actions.callApi({
        method: 'put',
        url: '/api/settings',
        body: { avatar_border_radius: avatarRadiusInput.value || '' },
        errorNotificationMessage: 'Error saving settings ',        
        onSuccess: (res) => {
          appState.update({ settings: { avatar_border_radius: avatarRadiusInput.value } });
          toast.success('Settings Saved Successfully');
          }              
      });
    }
