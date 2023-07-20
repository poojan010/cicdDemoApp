import React, {useState} from 'react';
import {StyleSheet, Text, TextInput, View} from 'react-native';

const App = () => {
  const [value1, setValue1] = useState('');
  const [value2, setValue2] = useState('');

  return (
    <View style={styles.screen}>
      <Text style={styles.text}>Welcome User </Text>
      <TextInput
        keyboardType="number-pad"
        value={value1}
        style={styles.input}
        onChangeText={(text: string) => setValue1(text)}
      />
      <TextInput
        keyboardType="number-pad"
        value={value2}
        style={styles.input}
        onChangeText={(text: string) => setValue2(text)}
      />
      <Text style={styles.answer}>
        Answer : {Number(value1) + Number(value2)}
      </Text>
    </View>
  );
};

export default App;

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    marginHorizontal: 10,
    justifyContent: 'center',
  },
  text: {
    fontSize: 18,
    color: 'red',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  input: {
    borderWidth: 1,
    borderColor: 'black',
    borderRadius: 5,
    marginVertical: 10,
  },
  answer: {
    fontSize: 18,
    marginTop: 15,
  },
});
