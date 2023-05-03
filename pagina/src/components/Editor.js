import React from 'react';
import CodeMirror from '@uiw/react-codemirror';
import { javascript } from '@codemirror/lang-javascript';
import { okaidia, okaidiaInit } from '@uiw/codemirror-theme-okaidia';

function Editor(props) {
  const onChange = React.useCallback((value, viewUpdate) => {
    props.input(value);
  }, []);
  return (
    <CodeMirror
    value={props.value}
    height="200px"
    theme={okaidia}
    extensions={[javascript({ jsx: true })]}
    onChange={onChange}
  />
  );
}
export default Editor;